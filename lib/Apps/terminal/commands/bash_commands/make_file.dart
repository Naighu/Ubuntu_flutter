import 'package:get/get.dart';
import 'package:ubuntu/controllers/file_controller.dart';

import 'command_packages.dart';

import 'ls.dart';

class Touch implements DecodeCommand {
  @override
  executeCommand(BuildContext context, int? id, String fileName) {
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    String message = touch(fileController, controller.path, fileName);
    controller.addOutputString(id!, message);
  }

  touch(FileController fileController, String? path, String fileName) {
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
      Shell shell = Shell.init()!;
      shell.create(path! + "/$fileName", option: "file");
      fileController.updateUi(path + "/$fileName");
      return "";
    } else
      return error;
  }
}

class Rm implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    String path, fileName, message;
    //compiling the path
    if (command.isNotEmpty) {
      if (command.startsWith("/") || command.split("/").length >= 2) {
        var a = command.split("/");
        fileName = a.removeLast();
        path = controller.path! + "/" + a.join("/").replaceFirst("/", "");
      } else {
        var a = command.split("/");
        fileName = a.removeLast();
        path = controller.path! + a.join("/");
      }
      message = rm(fileController, path, fileName);
    } else
      message = "Specify a File name";
    controller.addOutputString(id!, message);
  }

  rm(FileController fileController, String path, String fileName) {
    Ls ls = Ls();
    List items = ls.ls(path);
    String error = "File not Found";
    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items) {
        List split = item.path.split("/");
        split.removeLast();

        if (item is File &&
            item.path.trim() == (split.join("/") + "/$fileName").trim()) {
          error = "";
          break;
        }
      }
    }

    if (error.isEmpty) {
      Shell shell = Shell.init()!;
      shell.remove(path + "/$fileName", option: "file");
      fileController.updateUi(path + "/$fileName");
      return "";
    }
    return error;
  }
}
