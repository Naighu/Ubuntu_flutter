import 'package:flutter/material.dart';
import 'package:ubuntu/Apps/webview/webview.dart';

import '../Apps/terminal/terminal.dart';

class App {
  final String name, icon;
  Size size = Size(600.0, 600.0);
  bool showOnScreen = true, isMaximized = false, isOpened = false;
  Offset offset;
  Widget child;
  App({
    @required this.name,
    @required this.icon,
    @required this.offset,
    this.child,
  });
}

List<App> getApps(Size size) => [
      App(
          name: "Google Chrome",
          icon: "assets/app_icons/chrome.png",
          child: WebviewFrame(
            url: "https://www.google.com/webhp?igu=1",
            id: "bing",
          ),
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
        name: "Todo List",
        icon: "assets/app_icons/todolist.png",
        offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0),
        child: WebviewFrame(
          url: "https://todoist.com/showProject?id=220474322",
          id: "vscode",
        ),
      ),
      App(
          name: "File Explorer",
          icon: "assets/system/folder.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Vs code",
          icon: "assets/app_icons/vscode.png",
          child: WebviewFrame(
            url:
                "https://github1s.com/vivek9patel/vivek9patel.github.io/blob/HEAD/src/components/ubuntu.js",
            id: "vscode",
          ),
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Terminal",
          icon: "assets/app_icons/bash.png",
          child: Terminal(),
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Spotify",
          icon: "assets/app_icons/spotify.png",
          child: WebviewFrame(
            url:
                "https://open.spotify.com/embed/playlist/37i9dQZEVXbLZ52XmnySJg",
            id: "spottify",
          ),
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Settings",
          icon: "assets/app_icons/gnome-control-center.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
    ];
