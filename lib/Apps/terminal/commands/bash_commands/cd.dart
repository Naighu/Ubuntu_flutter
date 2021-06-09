import 'package:get/get.dart';

import 'command_packages.dart';

class Cd implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String folder) {
    final controller = Get.find<TerminalController>(tag: tag);
    WebShell shell = WebShell.init()!;
    List items = shell.listDir();
    folder = folder.startsWith("/") ? folder : "/$folder";
    String? newPath = cd(items, controller.path, folder);
    if (newPath != null) {
      controller.path = newPath;
      controller.addOutputString(id, "",
          header:
              "${controller.sudoMode ? "root:\$" : "naighu@ubuntu:-\$"}$newPath");

      //  controller.headers.add(newPath);
    } else {
      controller.addOutputString(id, "folder does not exist");
    }
  }

  String? cd(List items, String? currentPath, String folder) {
    String? newPath;
    for (var item in items) {
      if (item is Directory) {
        if (item.path.trim() == (currentPath! + folder).trim()) {
          newPath = item.path;
          break;
        }
      }
    }

    return newPath;
  }
}
