import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/show_commands.dart';
import 'package:ubuntu/constants.dart';

import '../controllers/terminal_controller.dart';

class TerminalBlock extends StatefulWidget {
  final String header;

  const TerminalBlock({Key key, this.header = ""}) : super(key: key);
  @override
  _TerminalBlockState createState() => _TerminalBlockState();
}

class _TerminalBlockState extends State<TerminalBlock> {
  String output = "";
  bool showOutput = false;
  final controller = Get.find<TerminalController>();
  @override
  Widget build(BuildContext context) {
    debugPrint("TerminalBlocks rebuilded $showOutput");
    return IntrinsicHeight(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("naighu@ubuntu:-\$${widget.header}",
                style: Theme.of(context).textTheme.bodyText2),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 20.0,
                    maxWidth: controller.windowSize.width - menuWidth),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 6.0),
                  child: TextField(
                      decoration: null,
                      autofocus: true,
                      cursorWidth: 7.0,
                      cursorHeight: 15.0,
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodyText1,
                      onSubmitted: (val) {
                        _onSubmitted(controller, val);
                      }),
                ),
              ),
            )
          ],
        ),
        showOutput
            ? Text(
                output,
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Offstage()
      ]),
    );
  }

  void _onSubmitted(TerminalController controller, String val) {
    showOutput = val.isEmpty ? false : true;
    String header = controller.path;

    if (showOutput) {
      List<String> commandsplit = val.split(" ");
      if (commands.containsKey(commandsplit[0])) {
        String message = commands[val.split(" ")[0]]
            .executeCommand(context, commandsplit.skip(1).join(" "));
        output = message.split(":").last;
        header = message.split(":")[0];
      } else {
        output = "No such command";
      }
      setState(() {});
    }
    controller.add(TerminalBlock(
      header: header,
    ));
  }
}
