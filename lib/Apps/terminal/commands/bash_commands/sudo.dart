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
      su(controller, tag, command, id);
    } else
      controller.addOutputString(id, "Command not found");
  }

  su(
    TerminalController controller,
    String tag,
    String command,
    int id,
  ) {
    if (!controller.sudoMode) {
      controller.addOutputString(id, "Enter the sudo password(press any key)\n",
          end: false);
      bool done = false;

      html.document.on["keypress"].listen((_) {
        if (!done) {
          done = true;
          execute(controller, command, tag, id);
          //  html.document.removeEventListener("keypress", (event) => null);
        }
      });
    } else
      execute(controller, command, tag, id);
  }

  void execute(
      TerminalController controller, String command, String tag, int id) {
    controller.sudoMode = true;
    List<String> commandsplit = command.split(" ");
    if (commands.containsKey(commandsplit[0])) {
      commands[command.split(" ")[0]]!
          .executeCommand(tag, id, commandsplit.skip(1).join(" "));
    } else if (commandsplit[0] == "su")
      controller.addOutputString(id, "", header: "root:-\$${controller.path}");
    else
      controller.addOutputString(id, "no such commands");
  }
}
