import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/terminal_controller.dart';

class TerminalBlock extends StatefulWidget {
  @override
  _TerminalBlockState createState() => _TerminalBlockState();
}

class _TerminalBlockState extends State<TerminalBlock> {
  String command = "";
  bool showOutput = false;
  @override
  Widget build(BuildContext context) {
    debugPrint("TerminalBlocks rebuilded $showOutput");
    return IntrinsicHeight(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Row(
            children: [
              Text("naigal@ubuntu:~\$ ",
                  style: Theme.of(context).textTheme.bodyText2),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 20.0,
                    maxWidth:
                        context.read<TerminalController>().windowSize.width -
                            120.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: TextField(
                    decoration: null,
                    autofocus: true,
                    cursorWidth: 7.0,
                    cursorHeight: 15.0,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText1,
                    onSubmitted: (val) {
                      command = val;
                      showOutput = val.isEmpty ? false : true;

                      setState(() {});
                      context.read<TerminalController>().add(TerminalBlock());
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        showOutput
            ? Text(
                "\n\n    $command\n\n",
                style: Theme.of(context).textTheme.bodyText1,
              )
            : Offstage()
      ]),
    );
  }
}
