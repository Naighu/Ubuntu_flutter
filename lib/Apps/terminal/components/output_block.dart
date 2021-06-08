import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apps/terminal/commands/bash_commands/command_packages.dart';

class OutputBlock extends StatelessWidget {
  final TerminalOutput output;
  final String tag;
  const OutputBlock({Key? key, required this.output, required this.tag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TerminalController>(tag: tag);
    return IntrinsicHeight(
        child: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: [
          for (String? text in controller.outputs[output.id].outputs)
            TextSpan(text: text)
        ])));
  }
}
