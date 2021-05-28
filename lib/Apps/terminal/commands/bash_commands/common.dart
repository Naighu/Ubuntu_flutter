import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Apps/terminal/controllers/terminal_controller.dart';

import '../shell.dart';

class Pwd implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    final controller = Get.find<TerminalController>();
    controller.addOutputString(id!, controller.path);
  }
}

class Clear implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    final controller = Get.find<TerminalController>();
    controller.removeAll();
    return "";
  }
}
