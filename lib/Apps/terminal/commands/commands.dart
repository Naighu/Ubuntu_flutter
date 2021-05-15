import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/shell.dart';
import 'package:ubuntu/Apps/terminal/controllers/terminal_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';

abstract class DecodeCommand {
  dynamic executeCommand(BuildContext context, String command);
}

class Ls implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String command) {
    final controller = Get.find<TerminalController>();
    List items = ls(controller.path);
    String _items = "";
    for (var item in items) {
      _items += item.path.split("/").last;
      _items += "  ";
    }
    return "${controller.path}:$_items";
  }

  List ls(String path) {
    Shell shell = Shell.init();
    List items = shell.listDir();
    List _items = [];
    for (var item in items) {
      List split = item.path.split("/");
      split.removeLast();
      if (split.join("/").trim() == path.trim()) {
        _items.add(item);
      }
    }
    return _items;
  }
}

class Pwd implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String command) {
    final controller = Get.find<TerminalController>();
    return "${controller.path}:${controller.path}";
  }
}

class Cd implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String command) {
    final controller = Get.find<TerminalController>();
    Shell shell = Shell.init();
    List items = shell.listDir();
    String folder = command.split(" ").last;
    folder = folder.startsWith("/") ? folder : "/$folder";
    String newPath = cd(items, controller.path, folder);
    if (newPath != controller.path) {
      print("equal");
      controller.path = newPath;
      newPath = newPath + ":" + " ";
      print(newPath);
    } else {
      newPath = " : ";
    }
    return newPath;
  }

  String cd(List items, String currentPath, String folder) {
    String newPath;
    for (var item in items) {
      if (item is Directory) {
        if (item.path.trim() == currentPath + folder) {
          newPath = item.path;
          break;
        }
      }
    }
    if (newPath == null) return currentPath;
    return newPath;
  }
}

class Mkdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String command) {
    final controller = Get.find<TerminalController>();
    String fileName = command.split(" ").last;
    final fileController = Get.find<FileController>();
    List items = Ls().ls(controller.path);
    bool dirAlreadyExist = false;
    for (var item in items) {
      if (item is Directory && item.path.split("/").last == fileName) {
        dirAlreadyExist = true;
        break;
      }
    }
    if (!dirAlreadyExist) {
      Shell shell = Shell.init();
      shell.createDir(controller.path + "/d-$fileName");
      // fileController.listFolders(controller.path);
      return ":";
    } else
      return "${controller.path}:File Already exist";
  }
}
