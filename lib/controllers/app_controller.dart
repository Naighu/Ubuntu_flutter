import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:get/get.dart';
import '../models/app.dart';

class AppController extends GetxController {
  final RxList appStack = [].obs;

  //List<App> get appStack => _appStack;
  // void addApp(App app) {
  //   _appStack.add(app);
  //   update();
  // }

  // void removeApp(App app) {
  //   _appStack.remove(app);
  //   update();
  // }

  void hide(App app) {
    app.showOnScreen = false;
    update();
  }

  void show(App app) {
    app.showOnScreen = true;
    update();
  }

  void changeOffset(App app, Offset offset) {
    app.offset = offset;
    update();
  }

  void maximize(App app, Size totalSize) {
    app.height = totalSize.height - topAppBarHeight;
    app.width = totalSize.width - menuWidth;
    app.offset = Offset(0, 0);
    app.isMaximized = true;

    update();
  }

  void minimize(App app, Size totalSize) {
    app.width = 600;
    app.height = 600;
    app.isMaximized = false;
    update();
  }
}
