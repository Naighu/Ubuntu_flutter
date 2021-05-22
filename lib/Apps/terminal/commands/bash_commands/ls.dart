import 'package:get/get.dart';
import 'package:ubuntu/constants.dart';

import 'command_packages.dart';

class Ls implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int id, String command) {
    final controller = Get.find<TerminalController>();

    String path;
    if (command.startsWith("/") || command.isEmpty)
      path = controller.path + command;
    else
      path = controller.path + "/" + command;

    List items = ls(path);
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
