import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Apps/profile/profilepage.dart';
import '../Apps/gedit/gedit.dart';
import '../Apps/webview/webview.dart';
import '../System_Apps/File_Explorer/file_explore.dart';
import '../Apps/Settings/settings_page.dart';
import '../Apps/terminal/terminal.dart';

/*
Inorder to add a new app ..
* first add the package name in the [installed-apps] section in the config file located at assets/config/system_config.json.
* Add the app in the [openApp] function to open which widget when the app is clicked.
*/

class App {
  final String name, icon, packageName;

  /// unique integer for the app in appStack.
  late int pid;

  /// parameters to be passed to the respective apps to work properly.
  Map? params;

  /// size of the window.
  late Size _size;
  Size get size => _getSize;

  bool hide = false, isMaximized = false;

  /// offset of the app window.
  late Offset _offset;
  Offset get offset => _getOffset;

  /// which widget to be opened when the app is clicked.
  /// Add the widget to the [openApp] function.
  Widget? child;
  App({
    required this.name,
    required this.icon,
    required this.packageName,
  }) {
    _size = Size(60, 70);
    _offset = Offset(20, _size.height - 70);
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

///Which widget should be opened when the app is clicked.
Widget? openApp(App app) {
  Widget? wid;

  switch (app.packageName) {
    case "settings":
      wid = SettingsPage(app: app);
      break;
    case "spottify":
      wid = WebviewFrame(app: app);
      break;
    case "vscode":
      wid = WebviewFrame(app: app);
      break;
    case "chrome":
      wid = WebviewFrame(app: app);
      break;
    case "explorer":
      wid = FileExplorer(app: app);
      break;
    case "terminal":
      wid = Terminal(app: app);
      break;
    case "gedit":
      wid = Gedit(app: app);
      break;
    case "profile":
      wid = ProfilePage(app: app);
      break;
  }
  return wid;
}
