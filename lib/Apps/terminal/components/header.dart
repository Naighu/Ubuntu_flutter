import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apps/terminal/commands/bash_commands/command_packages.dart';
import '../../../Apps/terminal/commands/show_commands.dart';

class Header extends StatefulWidget {
  final int id;
  final String header;
  const Header({required this.id, required this.header});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  ///inorder to avoid editing of the textfield when the enter key is pressed;
  bool readMode = false;
  final controller = Get.find<TerminalController>();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(
              widget.header.isEmpty
                  ? "naighu@ubuntu:-\$${controller.path}"
                  : widget.header + "-\$${controller.path}",
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
        controller.addOutputString(widget.id, "no such commands\n\n",
            end: false);
        controller.addOutputString(widget.id, "Available Commands are : \n\n",
            end: false);
        controller.addOutputString(
          widget.id,
          "* mkdir\n* rmdir\n* touch \n* rm \n* cd \n* ls\n* cat\n *sudo \n* pwd\n* clear\n",
        );
      }
    } else {
      controller.addOutputString(widget.id, "");
    }
  }
}
