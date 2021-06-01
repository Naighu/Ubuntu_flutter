import 'package:get/get.dart';

import 'command_packages.dart';

import 'ls.dart';

class Cat implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    final controller = Get.find<TerminalController>();
    String output = "";
    String path = Shell.init()!.getCorrectPath(command, controller.path!);
    String fileName = path.split("/").last;
    if (fileName.isEmpty) {
      output = "Specify a name";
    } else {
      List split = path.split("/");
      split.removeLast();
      bool isExist = checkFileExistOnWeb(split.join("/"), fileName, controller);
      if (isExist)
        output = cat(path); //get the content of the file.
      else
        output = "No such file";
    }
    controller.addOutputString(id!, output);
  }

  bool checkFileExistOnWeb(String path, String fileName, controller) {
    List items = Ls().ls(path);
    print("[Path is ] $path");

    bool isExist = false;
    for (var item in items) {
      List split = item.path.split("/");
      split.removeLast();
      print(item.path.trim() == (path + "/$fileName").trim());
      if (item is File && item.path.trim() == (path + "/$fileName").trim()) {
        //check if the path is correct.
        isExist = true;
        break;
      }
    }
    return isExist;
  }

  String cat(String path) {
    Shell shell = Shell.init()!;
    String contents = shell.getContents(path);
    return contents;
  }
}
