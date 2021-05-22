import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/show_commands.dart';

import '../controllers/terminal_controller.dart';

class TerminalBlock extends StatefulWidget {
  final int id;

  TerminalBlock({Key key, this.id}) : super(key: key);

  @override
  _TerminalBlockState createState() => _TerminalBlockState();
}

class _TerminalBlockState extends State<TerminalBlock> {
  final controller = Get.find<TerminalController>();
  bool readMode = false;

  @override
  Widget build(BuildContext context) {
    print("REadmode $readMode");
    return IntrinsicHeight(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("naighu@ubuntu:-\$${controller.headers[widget.id]}",
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
                        readMode = true;
                        _onSubmitted(controller, val);
                      }),
                ),
              ),
            )
          ],
        ),
        controller.outputs[widget.id].isNotEmpty
            ? Text(
                controller.outputs[widget.id],
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Offstage()
      ]),
    );
  }

  void _onSubmitted(TerminalController controller, String val) {
    if (val.isNotEmpty) {
      List<String> commandsplit = val.split(" ");
      String output;
      if (commands.containsKey(commandsplit[0])) {
        output = commands[val.split(" ")[0]]
            .executeCommand(context, widget.id, commandsplit.skip(1).join(" "));
      } else {
        output = "No such command";
      }
      if (controller.blocks.isNotEmpty) controller.outputs[widget.id] = output;
    }

    controller.add(widget.id);
    setState(() {});
  }
}
