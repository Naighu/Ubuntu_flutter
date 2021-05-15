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
    print("controller PAth : ${controller.path}");
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
  dynamic executeCommand(BuildContext context, String folder) {
    final controller = Get.find<TerminalController>();
    Shell shell = Shell.init();
    List items = shell.listDir();
    folder = folder.startsWith("/") ? folder : "/$folder";
    String newPath = cd(items, controller.path, folder);
    if (newPath != controller.path) {
      print("equal");
      controller.path = newPath;
      newPath = newPath + ":" + " ";
      print(newPath);
    } else {
      newPath = "${controller.path}: ";
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
    // List split = newPath.split("/");
    // String last = split.last;
    // split.removeLast();
    // return "${split.join("/")}/d-$last";
    return newPath;
  }
}

class Mkdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String fileName) {
    final controller = Get.find<TerminalController>();
    List items = Ls().ls(controller.path);
    String error = "";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items) {
        List split = item.path.split("/");
        if (item is Directory && split.join().trim() == fileName) {
          error = "Directory Already exist";
          break;
        }
      }
    }
    if (error.isEmpty) {
      Shell shell = Shell.init();
      shell.create(controller.path + "/$fileName");
      // fileController.listFolders(controller.path);
      return "${controller.path}:";
    } else
      return "${controller.path}:$error";
  }
}

class Rmdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String fileName) {
    final controller = Get.find<TerminalController>();
    List items = Ls().ls(controller.path);
    String error = "Not found";
    for (var item in items) {
      if (item is Directory && item.path.split("/").last == fileName) {
        error = "";
        break;
      }
    }
    if (error.isEmpty) {
      Shell shell = Shell.init();
      shell.removeDir(controller.path + "/$fileName");
      return ":";
    } else
      return "${controller.path}:$error";
  }
}

class Mv implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, String command) {
    final controller = Get.find<TerminalController>();
    String error = "";
    try {
      String src = command.split(" ")[0];
      String destination = command.split(" ")[1];
      List srcSplit = src.split("/");
      List dstSplit = destination.split("/");

      String path;
      if (srcSplit.length != 1) {
        srcSplit.removeLast();
        path = srcSplit.join("/");
      } else
        path = controller.path;

      Ls ls = Ls();
      List items = ls.ls(path);
      dstSplit.removeLast();
      dstSplit.removeLast();
      bool dst = dstSplit.isEmpty;
      if (dstSplit.isNotEmpty) {
        List destDir = ls.ls(dstSplit.join("/"));
        print(destDir);
        dstSplit = destination.split("/");
        dstSplit.removeLast();
        print(dstSplit.join("/"));
        if (_checkForSrcFile(destDir, dstSplit.join("/")))
          dst = true;
        else
          dst = false;
      }
      if (dst && _checkForSrcFile(items, src)) {
        Shell shell = Shell.init();
        String contents = shell.getContents(src);
        shell.removeDir(src);
        shell.create(destination, value: contents);
      } else
        error = "File or dir not found";
    } catch (e) {
      error =
          "Specify the path\n 1. '.' is not currently supported. \n2.Use the full Path ";
    }

    return "${controller.path}:$error";
  }

  bool _checkForSrcFile(List items, String path) {
    bool exist = false;
    for (var item in items) {
      if (item.path.trim() == path.trim()) {
        print("true");
        exist = true;
        break;
      }
    }
    return exist;
  }
}
