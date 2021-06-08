import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/file_controller.dart';

import 'command_packages.dart';

import 'ls.dart';

class Touch implements DecodeCommand {
  @override
  executeCommand(String tag, int id, String fileName) {
    final controller = Get.find<TerminalController>(tag: tag);
    final fileController = Get.find<FileController>();
    String message = touch(fileController, controller.path, fileName);
    controller.addOutputString(id, message);
  }

  touch(FileController fileController, String? path, String fileName,
      {String? contents = "null"}) {
    if (kIsWeb) return touchWeb(fileController, path, fileName);
  }

  touchWeb(FileController fileController, String? path, String fileName,
      {String? contents = "null"}) {
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
      WebShell shell = WebShell.init()!;
      shell.create(path! + "/$fileName", option: "file", value: contents);
      fileController.updateUi(path);
      return "";
    } else
      return error;
  }
}

class Rm implements DecodeCommand {
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
        if (fileName.isEmpty)
          message = "Specify a name";
        else
          message = rm(fileController, path, fileName);
        print(path);
      } else {
        message = "Incorrect path";
      }
    } else
      message = "Specify a File name";
    controller.addOutputString(id, message);
  }

  rm(FileController fileController, String path, String fileName) {
    if (kIsWeb) return rmWeb(fileController, path, fileName);
  }

  rmWeb(FileController fileController, String path, String fileName) {
    Ls ls = Ls();
    List items = ls.ls(path);
    String error = "File not Found";

    for (var item in items) {
      if (item is File && item.path.trim() == (path + "/$fileName").trim()) {
        error = "";
        break;
      }
    }

    if (error.isEmpty) {
      WebShell shell = WebShell.init()!;
      shell.remove(path + "/$fileName", option: "file");
      fileController.updateUi(path.trim());
      return "";
    }
    return error;
  }
}
