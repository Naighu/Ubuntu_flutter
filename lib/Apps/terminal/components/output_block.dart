import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apps/terminal/commands/bash_commands/command_packages.dart';

class OutputBlock extends StatelessWidget {
  final int id;

  const OutputBlock({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: GetBuilder<TerminalController>(
          id: id,
          assignId: true,
          builder: (controller) {
            return RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                  for (String? text in controller.outputs![id].outputs)
                    TextSpan(text: text)
                ]));
          }),
    );
  }
}
