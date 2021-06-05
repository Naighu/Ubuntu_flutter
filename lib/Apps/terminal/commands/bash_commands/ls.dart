import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'command_packages.dart';
import '../shell.dart';

class Ls implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    final controller = Get.find<TerminalController>();

    String path;
    if (command.startsWith("/") || command.isEmpty)
      path = controller.path! + command;
    else
      path = controller.path! + "/" + command;

    List items = ls(path);
    String _items = "";
    for (var item in items) {
      _items += item.path.split("/").last;
      _items += "  ";
    }
    controller.addOutputString(id!, _items);
  }

  ls(String? path) {
    if (kIsWeb) return lsWeb(path);
  }

  List lsWeb(String? path) {
    WebShell shell = WebShell.init()!;
    List items = shell.listDir();
    List _items = [];
    for (FileSystemEntity item in items) {
      if (item.path.getParentPath().trim() == path!.trim()) {
        _items.add(item);
      }
    }
    return _items;
  }
}
