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

  void create(String path, {value = "null"}) {
    CookieManager manager = CookieManager.init();
    manager.addToCookie("${_crtPath(path)}", value);
  }

  String _crtPath(String path) {
    List<String> split = path.split("/");
    String newPath = split.removeAt(0);

    for (String p in split) {
      print(p);
      if (!p.startsWith("d-"))
        newPath += "/d-$p";
      else
        newPath += "/$p";
    }
    return newPath;
  }

  void removeDir(String path) {
    print("[Removing Dir]");
    CookieManager manager = CookieManager.init();
    print(path);
    manager.removeCookie("${_crtPath(path)}");
  }

  String getContents(String path) {
    CookieManager manager = CookieManager.init();
    return manager.getCookie("${_crtPath(path)}");
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
