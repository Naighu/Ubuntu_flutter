import 'package:get/get.dart';

import 'command_packages.dart';

class Cd implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String folder) {
    final controller = Get.find<TerminalController>();
    Shell shell = Shell.init();
    List items = shell.listDir();
    folder = folder.startsWith("/") ? folder : "/$folder";
    String newPath = cd(items, controller.path, folder);
    if (newPath != controller.path) {
      controller.path = newPath;
      controller.addOutputString(
        id,
        "",
      );
      //  controller.headers.add(newPath);
    }
  }

  String cd(List items, String currentPath, String folder) {
    String newPath;
    for (var item in items) {
      if (item is Directory) {
        if (item.path.trim() == (currentPath + folder).trim()) {
          newPath = item.path;
          break;
        }
      }
    }
    if (newPath == null) return currentPath;
    return newPath;
  }
}
