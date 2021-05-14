import 'dart:io';

import 'package:ubuntu/Apps/terminal/commands/shell.dart';
import 'package:ubuntu/Apps/terminal/controllers/terminal_controller.dart';

abstract class DecodeCommand {
  dynamic executeCommand(TerminalController controller, String command);
}

class Ls implements DecodeCommand {
  @override
  dynamic executeCommand(TerminalController controller, String command) {
    Shell shell = Shell.init();
    List items = shell.listDir();
    return "${controller.path}:${ls(controller.path, items)}";
  }

  ls(String path, List items) {
    String _items = "";
    for (var item in items) {
      List split = item.path.split("/");
      split.removeLast();
      if (split.join("/").trim() == path.trim()) {
        _items += item.path.split("/").last;
        _items += "  ";
      }
    }
    return "$_items";
  }
}

class Pwd implements DecodeCommand {
  @override
  dynamic executeCommand(TerminalController controller, String command) {
    return "${controller.path}:${controller.path}";
  }
}

class Cd implements DecodeCommand {
  @override
  dynamic executeCommand(TerminalController controller, String command) {
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
