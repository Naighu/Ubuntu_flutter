import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/shell.dart';
import 'package:ubuntu/Apps/terminal/controllers/terminal_controller.dart';

abstract class DecodeCommand {
  dynamic executeCommand(BuildContext context, int id, String command);
}

class Ls implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String command) {
    final controller = Get.find<TerminalController>();

    List items = ls(controller.path);
    String _items = "";
    for (var item in items) {
      _items += item.path.split("/").last;
      _items += "  ";
    }
    return _items;
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
  dynamic executeCommand(BuildContext context, int id, String command) {
    final controller = Get.find<TerminalController>();
    return controller.path;
  }
}

class Clear implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String command) {
    final controller = Get.find<TerminalController>();
    controller.removeAll();
    return "";
  }
}

class Cd implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String folder) {
    final controller = Get.find<TerminalController>();
    Shell shell = Shell.init();
    List items = shell.listDir();
    folder = folder.startsWith("/") ? folder : "/$folder";
    String newPath = cd(items, controller.path, folder);
    if (newPath != controller.path) {
      controller.path = newPath;
      controller.headers.add(newPath);
    }
    return "";
  }

  String cd(List items, String currentPath, String folder) {
    String newPath;
    for (var item in items) {
      if (item is Directory) {
        if (item.path.trim() == (currentPath + folder).trim()) {
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

class Touch implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    List items = Ls().ls(controller.path);
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
      shell.create(controller.path + "/$fileName", option: "file");
      return "";
    } else
      return error;
  }
}

class Cat implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    List items = Ls().ls(controller.path);
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
          isExist = true;
          break;
        }
      }
      if (isExist)
        return cat(controller.path + "/$fileName");
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

class Rm implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String fileName) {
    final controller = Get.find<TerminalController>();
    return rm(controller.path, fileName);
  }

  rm(String path, String fileName) {
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
      return "";
    }
    return error;
  }
}
