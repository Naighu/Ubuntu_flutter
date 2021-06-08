import 'package:get/get.dart';

import 'command_packages.dart';

import 'ls.dart';

class Cat implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String command) {
    final controller = Get.find<TerminalController>(tag: tag);
    String output = "";
    String path = WebShell.init()!.getCorrectPath(command, controller.path!);
    String fileName = path.split("/").last;
    if (fileName.isEmpty) {
      output = "Specify a name";
    } else {
      bool isExist =
          checkFileExistOnWeb(path.getParentPath(), fileName, controller);
      if (isExist)
        output = cat(path); //get the content of the file.
      else
        output = "No such file";
    }
    controller.addOutputString(id, output);
  }

  bool checkFileExistOnWeb(String path, String fileName, controller) {
    List items = Ls().ls(path);
    print("[Path is ] $path");

    bool isExist = false;
    for (var item in items) {
      if (item is File && item.path.trim() == (path + "/$fileName").trim()) {
        //check if the path is correct.
        isExist = true;
        break;
      }
    }
    return isExist;
  }

  String cat(String path) {
    WebShell shell = WebShell.init()!;
    String contents = shell.getContents(path);
    return contents;
  }
}
