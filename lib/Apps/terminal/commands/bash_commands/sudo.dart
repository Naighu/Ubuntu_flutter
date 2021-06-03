import 'package:get/get.dart';

import '../show_commands.dart';
import 'command_packages.dart';

class Sudo implements DecodeCommand {
  @override
  executeCommand(BuildContext context, int? id, String command) async {
    final controller = Get.find<TerminalController>();

    controller.addOutputString(id!, "Switching to super user mode ...\n",
        end: false);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (command.isNotEmpty) {
      List<String> commandsplit = command.split(" ");
      if (commands.containsKey(commandsplit[0])) {
        commands[command.split(" ")[0]]!
            .executeCommand(context, id, commandsplit.skip(1).join(" "));
      } else {
        if (commandsplit[0] == "su") {
          su(controller, id);
        } else
          controller.addOutputString(id, "no such commands");
      }
    } else
      controller.addOutputString(id, "Command not found");
  }

  su(TerminalController controller, int id) {
    controller.addOutputString(id, "", header: "root");
  }
}
