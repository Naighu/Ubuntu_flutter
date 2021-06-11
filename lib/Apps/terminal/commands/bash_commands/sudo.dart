import 'dart:html';

import 'package:get/get.dart';
import 'dart:html' as html;

import '../show_commands.dart';
import 'command_packages.dart';

class Sudo implements DecodeCommand {
  @override
  executeCommand(String tag, int id, String command) async {
    final controller = Get.find<TerminalController>(tag: tag);

    controller.addOutputString(id, "Switching to super user mode ...\n",
        end: false);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (command.isNotEmpty) {
      List<String> commandsplit = command.split(" ");
      if (commands.containsKey(commandsplit[0])) {
        commands[command.split(" ")[0]]!
            .executeCommand(tag, id, commandsplit.skip(1).join(" "));
      } else {
        if (commandsplit[0] == "su") {
          su(controller, id, true);
        } else
          controller.addOutputString(id, "no such commands");
      }
    } else
      controller.addOutputString(id, "Command not found");
  }

  su(TerminalController controller, int id, bool permanent) {
    controller.addOutputString(id, "Enter the sudo password(press any key)",
        end: false);

    html.document.on["keypress"].listen((_) {
      controller.sudoMode = true;
      if (permanent)
        controller.addOutputString(id, "",
            header: "root:-\$${controller.path}");
    });
  }
}
