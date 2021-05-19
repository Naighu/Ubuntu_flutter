import 'package:get/get.dart';
import 'package:ubuntu/controllers/file_controller.dart';

import 'command_packages.dart';

import 'ls.dart';

class Touch implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    return touch(fileController, controller.path, fileName);
  }

  touch(FileController fileController, String path, String fileName) {
    List items = Ls().ls(path);
    String error = "";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items) {
        List split = item.path.split("/");
        split.removeLast();

        if (item is File &&
            item.path.trim() == (split.join("/") + "/$fileName").trim()) {
          error = "File Already exist";
          break;
        }
      }
    }
    if (error.isEmpty) {
      Shell shell = Shell.init();
      shell.create(path + "/$fileName", option: "file");
      File newFile = File(path + "/$fileName");
      fileController.add(newFile);
      return "";
    } else
      return error;
  }
}

class Rm implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    return rm(fileController, controller.path, fileName);
  }

  rm(FileController fileController, String path, String fileName) {
    Ls ls = Ls();
    List items = ls.ls(path);

    String error = "File Not Found \n\nNavigate to the Working Directory";
    for (var item in items) {
      if (item is File && item.path.split("/").last.trim() == fileName.trim()) {
        error = "";
        break;
      }
    }
    items = ls.ls(path + "/$fileName");
    if (items.isNotEmpty) error = "Directory is not empty";
    if (error.isEmpty) {
      Shell shell = Shell.init();
      shell.remove(path + "/$fileName", option: "file");
      fileController.delete(null);
      return "";
    }
    return error;
  }
}
