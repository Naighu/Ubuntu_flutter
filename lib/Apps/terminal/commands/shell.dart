import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ubuntu/utils/cookie_manager.dart';

class Shell {
  Shell._();
  static Shell _shell;
  static Shell init() {
    if (_shell == null) _shell = Shell._();
    return _shell;
  }

  List listDir() {
    if (kIsWeb)
      return _listItemsOnWeb();
    else
      throw "Not Implemented";
  }

  void createDir(String path) {
    CookieManager manager = CookieManager.init();
    manager.addToCookie(path, "Directory");
  }

  List _listItemsOnWeb() {
    CookieManager manager = CookieManager.init();
    List<String> cookies = manager.getAllCookie();
    List items = [];
    for (String cookie in cookies) {
      List<String> map = cookie.split("=");
      String name = map[0].split("/").last;

      if (name.startsWith("d-") ||
          name.startsWith(
              ".d-")) // if it starts with d then it is a directory. "." prefix indicates that it is a hidden directory
        items.add(
            Directory("${map[0].replaceAll("d-", "").replaceAll("~-", "")}"));
      else if (name.startsWith("~-") ||
          name.startsWith(
              ".~-")) // if it starts with ~ then it is a file. "." prefix indicates that it is a hidden file
        items.add(File("${map[0].replaceAll("d-", "").replaceAll("~-", "")}"));
    }

    return items;
  }
}
