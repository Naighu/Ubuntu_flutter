import 'package:flutter/material.dart';
import 'package:ubuntu/Apps/webview/webview.dart';

import '../Apps/terminal/terminal.dart';

class App {
  final String name, icon, packageName;
  Size _size;
  Size get size => _getSize;
  bool hide = false, isMaximized = false;
  Offset _offset;
  Offset get offset => _getOffset;
  Widget child;
  BuildContext context;
  App({
    @required this.name,
    @required this.icon,
    @required this.context,
    @required this.packageName,
    this.child,
  }) {
    _size = Size(60, 70);
    _offset = Offset(_size.width - 60, _size.height - 70);
  }

  get _getSize {
    Size size = MediaQuery.of(context).size;
    final a = Size(
        (_size.width / 100) * size.width, (_size.height / 100) * size.height);

    return a;
  }

  set setSize(Size newSize) {
    Size totalSize = MediaQuery.of(context).size;
    _size = Size((newSize.width / totalSize.width) * 100,
        (newSize.height / totalSize.height) * 100);
  }

  get _getOffset {
    Size size = MediaQuery.of(context).size;
    final a = Offset(
        (_offset.dx / 100) * size.width, (_offset.dy / 100) * size.height);

    return a;
  }

  set setOffset(Offset newOffset) {
    Size totalSize = MediaQuery.of(context).size;
    _offset = Offset((newOffset.dx / totalSize.width) * 100,
        (newOffset.dy / totalSize.height) * 100);
  }
}

List<App> getApps(BuildContext context) => [
      App(
        name: "Google Chrome",
        icon: "assets/app_icons/chrome.png",
        context: context,
        child: WebviewFrame(
          url: "https://www.google.com/webhp?igu=1",
          id: "Google chrome",
        ),
        packageName: "chrome",
      ),
      App(
        name: "File Explorer",
        icon: "assets/system/folder.png",
        context: context,
        packageName: "explorer",
      ),
      App(
        name: "Vs code",
        icon: "assets/app_icons/vscode.png",
        context: context,
        child: WebviewFrame(
          url:
              "https://github1s.com/vivek9patel/vivek9patel.github.io/blob/HEAD/src/components/ubuntu.js",
          id: "vscode",
        ),
        packageName: "vscode",
      ),
      App(
        name: "Terminal",
        icon: "assets/app_icons/bash.png",
        child: Terminal(),
        context: context,
        packageName: "terminal",
      ),
      App(
        name: "Spotify",
        icon: "assets/app_icons/spotify.png",
        child: WebviewFrame(
          url: "https://open.spotify.com/embed/playlist/37i9dQZEVXbLZ52XmnySJg",
          id: "spottify",
        ),
        context: context,
        packageName: "spottify",
      ),
      App(
        name: "Settings",
        icon: "assets/app_icons/gnome-control-center.png",
        context: context,
        packageName: "settings",
      )
    ];
