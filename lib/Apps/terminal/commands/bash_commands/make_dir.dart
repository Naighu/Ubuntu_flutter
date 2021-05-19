import 'package:get/get.dart';

import 'command_packages.dart';

class Mkdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();

    return mkdir(controller.path, fileName);
  }

  String mkdir(String path, String fileName) {
    List items = Ls().ls(path);
    String error = "";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items) {
        List split = item.path.split("/");
        split.removeLast();

        if (item is Directory &&
            item.path.trim() == split.join("/") + "/$fileName") {
          error = "Directory Already exist";
          break;
        }
      }
    }
    if (error.isEmpty) {
      Shell shell = Shell.init();
      shell.create(path + "/$fileName");
      return "";
    } else
      return error;
  }
}

class Rmdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    return rmdir(controller.path, fileName);
  }

  rmdir(String path, String fileName) {
    print("Rm ing");
    Ls ls = Ls();
    List items = ls.ls(path);

    String error = "File Not Found \n\nNavigate to the Working Directory";
    for (var item in items) {
      if (item is Directory &&
          item.path.split("/").last.trim() == fileName.trim()) {
        error = "";
        break;
      }
    }
    items = ls.ls(path + "/$fileName");
    if (items.isNotEmpty) error = "Directory is not empty";
    if (error.isEmpty) {
      Shell shell = Shell.init();
      shell.remove(path + "/$fileName");
      print("renoved");
      return "";
    }

    return error;
  }
}
