import 'package:get/get.dart';
import '../../../../Apps/terminal/controllers/terminal_controller.dart';

import '../shell.dart';

class Pwd implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String command) {
    final controller = Get.find<TerminalController>(tag: tag);
    print("PAth is ${controller.path}");
    controller.addOutputString(id, controller.path);
  }
}

class Clear implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String command) {
    final controller = Get.find<TerminalController>(tag: tag);
    controller.removeAll(tag);
    return "";
  }
}
