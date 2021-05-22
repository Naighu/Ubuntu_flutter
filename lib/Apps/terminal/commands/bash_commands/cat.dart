import 'package:get/get.dart';

import 'command_packages.dart';

import 'ls.dart';

class Cat implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String command) {
    final controller = Get.find<TerminalController>();
    String path, fileName;

    //compiling the path
    if (command.startsWith("/") || command.split("/").length >= 2) {
      var a = command.split("/");
      a.removeLast();
      path = controller.path + "/" + a.join("/").replaceFirst("/", "");
      fileName = command.split("/").last;
    } else if (command.isNotEmpty) {
      var a = command.split("/");
      a.removeLast();
      path = controller.path + "/" + a.join("/");
      fileName = command;
    } else
      fileName = "";

    List items = Ls().ls(path);
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
          //check if the path is correct.
          isExist = true;
          break;
        }
      }
      if (isExist)
        return cat(path + "/$fileName"); //get the content of the file.
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
