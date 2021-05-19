import 'package:get/get.dart';

import 'command_packages.dart';

import 'ls.dart';

class Cat implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    List items = Ls().ls(controller.path);
    String error = "";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      bool isExist = false;
      for (var item in items) {
        List split = item.path.split("/");
        split.removeLast();

        if (item is File &&
            item.path.trim() == (split.join("/") + "/$fileName").trim()) {
          isExist = true;
          break;
        }
      }
      if (isExist)
        return cat(controller.path + "/$fileName");
      else
        error = "No such file";
    }

    return error;
  }

  String cat(String path) {
    Shell shell = Shell.init();
    String contents = shell.getContents(path);
    return contents;
  }
}
