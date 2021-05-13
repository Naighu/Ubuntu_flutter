import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Apps/terminal/controllers/terminal_controller.dart';
import '../Apps/terminal/terminal.dart';

class App {
  final String name, icon;
  double height = 600.0, width = 600.0;
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
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Todo List",
          icon: "assets/app_icons/todolist.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "File Explorer",
          icon: "assets/system/folder.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Vs code",
          icon: "assets/app_icons/vscode.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Terminal",
          icon: "assets/app_icons/bash.png",
          child: ChangeNotifierProvider(
            create: (context) => TerminalController(Size(600, 600)),
            child: Terminal(),
          ),
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Spotify",
          icon: "assets/app_icons/spotify.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
      App(
          name: "Settings",
          icon: "assets/app_icons/gnome-control-center.png",
          offset: Offset(size.width * 0.5 - 600.0, size.height - 600.0)),
    ];
