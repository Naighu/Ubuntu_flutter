import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'command_packages.dart';

class Cd implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String folder) {
    final controller = Get.find<TerminalController>(tag: tag);
    String? newPath;

    if (folder == "..") {
      newPath = controller.path!.getParentPath();
      if (newPath.isEmpty) newPath = controller.path;
    } else if (kIsWeb) {
      folder = folder.startsWith("/") ? folder : "/$folder";
      newPath = cdWeb(controller.path, folder);
    }
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

  String? cdWeb(String? currentPath, String folder) {
    WebShell shell = WebShell.init()!;
    List items = shell.listDir();
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
