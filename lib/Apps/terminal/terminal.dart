import 'package:flutter/material.dart';
import 'controllers/terminal_controller.dart';
import 'package:provider/provider.dart';

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        height: context.read<TerminalController>().windowSize.height - 80.0,
        width: context.read<TerminalController>().windowSize.width,
        child: ListView.builder(
            itemCount: context.watch<TerminalController>().blocks.length,
            itemBuilder: (context, index) {
              return context.watch<TerminalController>().blocks[index];
            }));
  }
}
