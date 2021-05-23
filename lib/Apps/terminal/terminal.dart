import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/terminal_controller.dart';

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<TerminalController>(
        init: TerminalController(),
        builder: (controller) {
          return Container(
              color: Theme.of(context).primaryColor,
              child: ListView(
                key: Key(controller.cleared
                    .toString()), //inorder to repaint the listview when clear command is executed
                children: [for (var block in controller.blocks) block],
              ));
        });
  }
}
