import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/components/terminal_block.dart';
import 'controllers/terminal_controller.dart';

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TerminalController>(
        init: TerminalController(),
        builder: (controller) {
          return Container(
              color: Theme.of(context).primaryColor,
              child: ListView(
                key: Key(controller.cleared
                    .toString()), //inorder to repaint the listview
                children: [
                  for (TerminalBlock block in controller.blocks) block
                ],
              ));
        });
  }
}
