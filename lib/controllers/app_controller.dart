import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:get/get.dart';
import '../models/app.dart';

class AppController extends GetxController {
  final RxList appStack = [].obs;
  int key = 0;
  Size prevSize;
  Offset prevOffset;

  void addByIgnoringDuplicates(App app) {
    if (!appStack.checkPackageName(app.packageName)) appStack.add(app);
  }

  void hide(App app) {
    app.hide = true;

    update();
  }

  void show(String packageName) {
    for (App app in appStack)
      if (app.packageName == packageName) {
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
    appStack.remove(app);
  }

  void minimize(App app) {
    app.setSize = prevSize;
    app.setOffset = prevOffset;
    app.isMaximized = false;
    update();
  }
}

extension on RxList {
  bool checkPackageName(String packageName) {
    for (App a in this) if (a.packageName == packageName) return true;
    return false;
  }
}
