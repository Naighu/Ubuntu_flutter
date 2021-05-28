import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apps/terminal/commands/bash_commands/command_packages.dart';
import '../../../Apps/terminal/commands/show_commands.dart';

class Header extends StatefulWidget {
  final int? id;
  final String header;
  const Header({this.id, this.header = ""});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool readMode =
      false; //inorder to avoid editing of the textfield when enter key is pressed;
  final controller = Get.find<TerminalController>();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text("naighu@ubuntu:-\$${controller.path}",
              style: Theme.of(context).textTheme.bodyText2),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 20.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 6.0),
                child: TextField(
                    decoration: null,
                    autofocus: true,
                    readOnly: readMode,
                    cursorWidth: 7.0,
                    cursorHeight: 15.0,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText1,
                    onSubmitted: (val) {
                      setState(() {
                        readMode = true;
                      });
                      // Future is added inorder to run the [_onSubmitted] function after the setState.
                      Future(() {
                        _onSubmitted(val);
                      });
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSubmitted(String val) {
    if (val.isNotEmpty) {
      List<String> commandsplit = val.split(" ");
      if (commands.containsKey(commandsplit[0])) {
        commands[val.split(" ")[0]]!
            .executeCommand(context, widget.id, commandsplit.skip(1).join(" "));
      } else {
        controller.addOutputString(widget.id!, "no such commands");
      }
    }
  }
}
