import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Apps/gedit/gedit.dart';
import '../Apps/webview/webview.dart';
import '../System_Apps/File_Explorer/file_explore.dart';
import '../System_Apps/Settings/settings_page.dart';

import '../Apps/terminal/terminal.dart';

class App {
  final String name, icon, packageName;
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
}

List<App> getApps() => [
      App(
        name: "Google Chrome",
        icon: "assets/app_icons/chrome.png",
        // child: WebviewFrame(
        //   url: "https://www.google.com/webhp?igu=1",
        //   id: "Google chrome",
        // ),
        packageName: "chrome",
      ),
      App(
        name: "File Explorer",
        icon: "assets/system/folder.png",
        packageName: "explorer",
      ),
      App(
        name: "Vs code",
        icon: "assets/app_icons/vscode.png",
        // child: WebviewFrame(
        //   url:
        //       "https://github1s.com/vivek9patel/vivek9patel.github.io/blob/HEAD/src/components/ubuntu.js",
        //   id: "vscode",
        // ),
        packageName: "vscode",
      ),
      App(
        name: "Terminal",
        icon: "assets/app_icons/bash.png",
        packageName: "terminal",
      ),
      App(
        name: "Spotify",
        icon: "assets/app_icons/spotify.png",
        // child: WebviewFrame(
        //   url: "https://open.spotify.com/embed/playlist/37i9dQZEVXbLZ52XmnySJg",
        //   id: "spottify",
        // ),
        packageName: "spottify",
      ),
      App(
        name: "Settings",
        icon: "assets/app_icons/gnome-control-center.png",
        packageName: "settings",
      ),
      App(
        name: "Gedit",
        icon: "assets/app_icons/gedit.png",
        packageName: "gedit",
      ),
    ];

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
  }
  return wid;
}
