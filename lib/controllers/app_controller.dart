import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:get/get.dart';
import '../models/app.dart';

class AppController extends GetxController {
  final List _appStack = [];
  List get appStack => _appStack;
  int key = 0;
  Size? prevSize;
  Offset? prevOffset;

  void addApp(App? app, {Map? params, bool addByIgnoringDuplicates = false}) {
    if (addByIgnoringDuplicates) {
      if (!appStack.checkPackageName(app!.packageName)) {
        app.child = openApp(app, params: params);
        _appStack.add(app);
      }
    } else {
      app!.child = openApp(app, params: params);
      _appStack.add(app);
    }
    update();
  }

  void removeApp(App app, {bool removeAllDuplicates = false}) {
    for (int i = 0; i < _appStack.length; i++)
      if (app.packageName == _appStack[i].packageName) {
        _appStack.removeAt(i);
        if (!removeAllDuplicates) break;
      }
    update();
  }

  void hide(App app) {
    app.hide = true;

    update();
  }

  App? getAppByPackageName(String? packageName) {
    App? a;
    for (App app in getApps())
      if (app.packageName == packageName) {
        a = app;
        break;
      }
    return a;
  }

  void show(String packageName) {
    for (App? app in appStack )
      if (app!.packageName == packageName) {
        app.hide = false;
      }
    update();
  }

  void maximize(App app, Size totalSize) {
    app.setSize = Size(totalSize.width, totalSize.height - topAppBarHeight);
    prevOffset = app.offset;
    app.setOffset = Offset(0, 0);

    app.isMaximized = true;

    update();
  }

  void closeApp(App app) {
    minimize(app);
    removeApp(app);
  }

  void minimize(App app) {
    app.setSize = prevSize!;
    app.setOffset = prevOffset!;
    app.isMaximized = false;
    update();
  }
}

extension on List {
  bool checkPackageName(String packageName) {
    for (App? a in this as Iterable<App?>) if (a!.packageName == packageName) return true;
    return false;
  }
}
