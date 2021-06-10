import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:get/get.dart';
import 'package:ubuntu/utils/system_files.dart';
import '../models/app.dart';

class AppController extends GetxController {
  final List<List<App>> _appStack = [];
  List<List<App>> get appStack => _appStack;
  int key = 0;

  ///keeps track of prevSize of the appWindow
  Size? prevSize;

  ///keeps track of prevOffset of the appWindow
  Offset? prevOffset;

  /// add App to the stack.
  /// [params] send the parameters to the app

  void addApp(App? app, {Map? params}) {
    app!.child = openApp(app);
    app.params = params;
    bool flag = false;
    for (int i = 0; i < _appStack.length; i++)
      for (App a in _appStack[i]) {
        if (a.packageName == app.packageName) {
          app.pid = int.parse("$i" + "${_appStack[i].length}");
          _appStack[i].add(app);
          flag = true;
          debugPrint("[${app.packageName} IS ADDED]");
          break;
        }
      }
    if (!flag) {
      app.pid = _appStack.length;
      _appStack.add([app]);
      debugPrint("[${app.packageName} IS ADDED]");
    }

    update();
  }

  /// removes the first app with given package name from the [appstack]\n
  /// [removeAllDuplicates] it will remove all the app with same packagename
  void removeApp(App app, {bool removeAllDuplicates = false}) {
    for (List<App> apps in _appStack)
      for (int i = 0; i < apps.length; i++) {
        if (apps[i] == app) {
          apps.removeAt(i);
          if (apps.isEmpty) _appStack.remove(apps);
          debugPrint("[${app.packageName} IS REMOVED]");
        }
      }
    update();
  }

  /// move the app to the last of the [appStack] list.

  void moveToFront(App app) {
    for (List<App> apps in _appStack)
      for (App a in apps) {
        if (a == app) {
          apps.remove(app);
          apps.add(app);
          _appStack.remove(apps);
          _appStack.add(apps);
          update();
        }
      }
  }

  /// hide the app in the menubar
  void hide(App app) {
    app.hide = true;

    update();
  }

  ///Returns [App] of the specified packagename
  App? getAppByPackageName(String? packageName) {
    List b = SystemFiles.getObject().getInstalledApps()!;

    for (Map c in b)
      if (c["packageName"] == packageName) return App.fromJson(c);
  }

  ///show the app on screen
  void show(App app) {
    app.hide = false;

    update();
  }

  ///maximize the app window size
  void maximize(App app, Size totalSize) {
    app.setSize = Size(totalSize.width, totalSize.height - topAppBarHeight);
    prevOffset = app.offset;
    app.setOffset = Offset(0, 0);

    app.isMaximized = true;

    update();
  }

  ///remove the app from stack
  ///it will minimize the app first then remove the app from stack
  void closeApp(App app) {
    minimize(app);
    removeApp(app);
  }

  ///minimize the app window size
  /// set the [prevSize] and [prevOffset] to the app window
  void minimize(App app) {
    app.setSize = prevSize!;
    app.setOffset = prevOffset!;
    app.isMaximized = false;
    update();
  }
}
