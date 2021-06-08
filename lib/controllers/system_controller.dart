import 'dart:html';

import 'package:get/get.dart';
import 'package:ubuntu/models/file.dart';
import '../constants.dart';

class SystemController extends GetxController {
  ///track the width of the menubar
  final menubarWidth = menuWidth.obs;

  ///number of terminal apps opened
  int terminalControllerTags = 0;

  ///desktop wallpaper
  var desktopWallpaper;
  SystemController() {
    if (window.localStorage.containsKey("wallpaper"))
      desktopWallpaper = window.localStorage["wallpaper"].obs;
    else
      desktopWallpaper = "wall-2.png".obs;
  }

  /// track the copy/paste operations.
  MyFile? clipboard;
}
