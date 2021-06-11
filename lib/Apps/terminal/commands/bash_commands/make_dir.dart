import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/file.dart';

import 'command_packages.dart';

class Mkdir implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String folderName) {
    final controller = Get.find<TerminalController>(tag: tag);
    final fileController = Get.find<FileController>();
    String? message = mkdir(fileController, controller.path, folderName);
    controller.addOutputString(id, message);
  }

  String? mkdir(FileController fileController, String? path, String fileName) {
    if (kIsWeb) return mkdirWeb(fileController, path, fileName);
  }

  String mkdirWeb(
      FileController fileController, String? path, String fileName) {
    String error = "";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      LinuxDirectory dir = LinuxDirectory(path! + "/$fileName");
      if (dir.existsSync()) error = "Directory Already exist";
    }
    if (error.isEmpty) {
      WebShell shell = WebShell.init()!;
      shell.create((path! + "/$fileName").trim());
      fileController.updateUi(path);
      return "";
    } else
      return error;
  }
}

class Rmdir implements DecodeCommand {
  @override
  dynamic executeCommand(String tag, int id, String command) {
    final controller = Get.find<TerminalController>(tag: tag);
    final fileController = Get.find<FileController>();
    String message;
    //compiling the path
    if (command.isNotEmpty) {
      String path = WebShell.init()!.getCorrectPath(command, controller.path!);
      if (path.isNotEmpty) {
        List a = path.split("/");

        String fileName = a.removeLast();
        path = a.join("/");

        message = rmdir(fileController, path, fileName);
      } else {
        message = "Incorrect path";
      }
    } else
      message = "Specify a Directory name";
    controller.addOutputString(id, message);
  }

  rmdir(FileController fileController, String path, String fileName) {
    if (kIsWeb) return rmdirWeb(fileController, path, fileName);
  }

  rmdirWeb(FileController fileController, String path, String fileName) {
    Ls ls = Ls();
    //   List items = ls.ls(path);
    String error = "Directory Not Found";
    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      LinuxDirectory dir = LinuxDirectory(path + "/$fileName");
      if (dir.existsSync()) {
        error = "";
      }
    }

    if (error.isEmpty) {
      var dirs = ls.ls(path +
          "/$fileName"); //checking if the selected folder is empty or not
      if (dirs.isEmpty) {
        WebShell shell = WebShell.init()!;

        shell.remove(path + "/$fileName");

        fileController.updateUi(path);
        return "";
      } else
        error = "Directory is not empty";
    }

    return error;
  }
}
