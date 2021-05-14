import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/terminal_controller.dart';

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TerminalController>(
        init: TerminalController(Size(600, 600)),
        builder: (controller) {
          Get.put(controller);
          return Container(
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                  itemCount: controller.blocks.length,
                  itemBuilder: (context, index) {
                    return controller.blocks[index];
                  }));
        });
  }
}
