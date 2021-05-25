import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/models/app.dart';
import 'controllers/terminal_controller.dart';

class Terminal extends StatelessWidget {
  final App app;
  final Map params;

  const Terminal({Key key, this.app, this.params}) : super(key: key);
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
