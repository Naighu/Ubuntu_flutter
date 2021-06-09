import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apps/terminal/commands/bash_commands/command_packages.dart';
import '../../../Apps/terminal/commands/show_commands.dart';

class HeaderBlock extends StatefulWidget {
  final String tag;
  final Header header;
  const HeaderBlock({required this.header, required this.tag, Key? key})
      : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderBlock> {
  ///inorder to avoid editing  the textfield when the enter key is pressed;
  bool readMode = false;
  late TerminalController controller;
  @override
  void initState() {
    controller = Get.find<TerminalController>(tag: widget.tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(widget.header.header,
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
    print("[Tag NAme is] : ${widget.tag}");
    print("[Id NAme is] : ${widget.header.id}");
    if (val.isNotEmpty) {
      List<String> commandsplit = val.split(" ");
      if (commands.containsKey(commandsplit[0])) {
        commands[val.split(" ")[0]]!.executeCommand(
            widget.tag, widget.header.id, commandsplit.skip(1).join(" "));
      } else {
        controller.addOutputString(widget.header.id, "no such commands\n\n",
            end: false);
        controller.addOutputString(
            widget.header.id, "Available Commands are : \n\n",
            end: false);
        controller.addOutputString(
          widget.header.id,
          "* mkdir\n* rmdir\n* touch \n* rm \n* cd \n* ls\n* cat\n *sudo \n* pwd\n* clear\n",
        );
      }
    } else
      controller.addOutputString(widget.header.id, "");
  }
}
