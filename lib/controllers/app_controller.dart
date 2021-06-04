import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:get/get.dart';
import 'package:ubuntu/utils/system_files.dart';
import '../models/app.dart';

class AppController extends GetxController {
  final List _appStack = [];
  List get appStack => _appStack;
  int key = 0;
  Size? prevSize;
  Offset? prevOffset;

  /// add App to the stack.
  /// [params] send the parameters to the app
  /// [addByIgnoringDuplicates] if the app with same packagename already present in the stack ,it will not add.

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

  /// removes the first app with given package name from the [appstack]
  /// [removeAllDuplicates] it will remove all the app with same packagename
  void removeApp(App app, {bool removeAllDuplicates = false}) {
    for (int i = 0; i < _appStack.length; i++)
      if (app.packageName == _appStack[i].packageName) {
        _appStack.removeAt(i);
        if (!removeAllDuplicates) break;
      }
    update();
  }

  /// move the app to the last of the [appStack] list.

  void moveToFront(App app) {
    _appStack.remove(app);
    _appStack.add(app);
    update();
  }

  /// hide the app in the menubar
  void hide(App app) {
    app.hide = true;

    update();
  }

  ///Returns [App] of the specified packagename
  App? getAppByPackageName(String? packageName) {
    App? a;

    for (App app in installedApps)
      if (app.packageName == packageName) {
        a = app;
        break;
      }
    return a;
  }

  ///show the app on screen
  void show(String packageName) {
    for (App app in appStack)
      if (app.packageName == packageName) {
        app.hide = false;
      }
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

extension on List {
  bool checkPackageName(String packageName) {
    for (App? a in this) if (a!.packageName == packageName) return true;
    return false;
  }
}
