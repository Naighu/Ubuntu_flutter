import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/components/header.dart';
import 'package:ubuntu/Apps/terminal/components/output_block.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/controllers/system_controller.dart';
import '../../models/app.dart';
import 'controllers/terminal_controller.dart';

class Terminal extends StatelessWidget {
  final App app;

  const Terminal({Key? key, required this.app}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int tag = Get.find<SystemController>().terminalControllerTags + 1;
    Get.find<SystemController>().terminalControllerTags = tag;

    return Container(
        color: Theme.of(context).primaryColor,
        child: GetBuilder<TerminalController>(
            tag: "$tag",
            init: TerminalController(
                app: app, path: app.params?["pwd"] ?? rootDir),
            builder: (controller) {
              return GetBuilder<TerminalController>(
                  key: Key(controller.cleared.toString()),
                  tag: "$tag",
                  builder: (_) {
                    return ListView(
                        children:
                            List.generate(controller.blocks.length, (index) {
                      if (controller.blocks[index] is Header)
                        return HeaderBlock(
                          tag: "$tag",
                          header: controller.blocks[index],
                        );
                      else if (controller.blocks[index] is TerminalOutput)
                        return OutputBlock(
                            tag: "$tag", output: controller.blocks[index]);
                      return Offstage();
                    }));
                  });
            }));
  }
}
