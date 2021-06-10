import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Apps/profile/profilepage.dart';
import '../Apps/gedit/gedit.dart';
import '../Apps/webview/webview.dart';
import '../System_Apps/File_Explorer/file_explore.dart';
import '../Apps/Settings/settings_page.dart';
import '../Apps/terminal/terminal.dart';

class App {
  final String name, icon, packageName;

  ///unique integer for the app
  late int pid;
  late Size _size;
  Size get size => _getSize;
  bool hide = false, isMaximized = false;
  late Offset _offset;
  Offset get offset => _getOffset;
  Widget? child;
  App({
    required this.name,
    required this.icon,
    required this.packageName,
  }) {
    _size = Size(60, 70);
    _offset = Offset(_size.width - 60, _size.height - 70);
  }

  get _getSize {
    Size size = Get.size;
    final a = Size(
        (_size.width / 100) * size.width, (_size.height / 100) * size.height);

    return a;
  }

  set setSize(Size newSize) {
    Size totalSize = Get.size;
    _size = Size((newSize.width / totalSize.width) * 100,
        (newSize.height / totalSize.height) * 100);
  }

  get _getOffset {
    Size size = Get.size;
    final a = Offset(
        (_offset.dx / 100) * size.width, (_offset.dy / 100) * size.height);

    return a;
  }

  set setOffset(Offset newOffset) {
    Size totalSize = Get.size;
    _offset = Offset((newOffset.dx / totalSize.width) * 100,
        (newOffset.dy / totalSize.height) * 100);
  }

  factory App.fromJson(Map json) => App(
      icon: json["icon"], name: json["name"], packageName: json["packageName"]);
}

Widget? openApp(App app, {Map? params}) {
  print(params);
  Widget? wid;
  switch (app.packageName) {
    case "settings":
      wid = SettingsPage();
      break;
    case "spottify":
      wid = WebviewFrame(app: app, params: params);
      break;
    case "vscode":
      wid = WebviewFrame(app: app, params: params);
      break;
    case "chrome":
      wid = WebviewFrame(app: app, params: params);
      break;
    case "explorer":
      wid = FileExplorer(app: app, params: params);
      break;
    case "terminal":
      wid = Terminal(app: app, params: params);
      break;
    case "gedit":
      wid = Gedit(
        app: app,
        params: params,
      );
      break;
    case "profile":
      wid = ProfilePage(
        app: app,
        params: params,
      );
      break;
  }
  return wid;
}
