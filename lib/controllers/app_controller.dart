import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:get/get.dart';
import '../models/app.dart';

class AppController extends GetxController {
  final RxList appStack = [].obs;
  int key = 0;
  Size prevSize;
  Offset prevOffset;
  void hide(App app) {
    app.showOnScreen = false;
    update();
  }

  void show(App app) {
    app.showOnScreen = true;
    update();
  }

  void maximize(App app, Size totalSize) {
    prevSize = app.size;
    app.size = Size(totalSize.width, totalSize.height - topAppBarHeight);
    prevOffset = app.offset;
    app.offset = Offset(0, 0);

    app.isMaximized = true;

    update();
  }

  void closeApp(App app) {
    minimize(app);
    appStack.remove(app);
    print("REmoved : ${app.name}");
    for (App a in appStack) print("Available : ${a.name}");
  }

  void minimize(App app) {
    app.size = prevSize;
    app.offset = prevOffset;
    app.isMaximized = false;
    update();
  }
}
