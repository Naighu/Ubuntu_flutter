import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ubuntu/models/file.dart';
import '../../../utils/cookie_manager.dart';

abstract class DecodeCommand {
  dynamic executeCommand(String tag, int id, String command);
}

/// Back bone of the file/folder storage in web.
/// files/folders are stored in cookies.
/// files are stored using a prefix `~`.
/// folder are stored using a prefix `d`.

class WebShell {
  WebShell._();
  static WebShell? _shell;
  static WebShell? init() {
    if (_shell == null) _shell = WebShell._();
    return _shell;
  }

  List listDir() {
    if (kIsWeb)
      return _listItemsOnWeb();
    else
      throw "Not Implemented";
  }

  void create(String path, {option = "dir", value = "null"}) {
    CookieManager manager = CookieManager.init();
    manager.addToCookie("${_crtPath(path, option: option)}", value);
  }

  void updateFile(String path, String content) {
    remove(path, option: "file");
    create(path, option: "file", value: content);
  }

  String _crtPath(String path, {option = "dir"}) {
    List<String> split = path.split("/");
    String newPath = split.removeAt(0);
    String? file;
    if (option != "dir") file = split.removeLast();

    for (String p in split) {
      if (!p.startsWith("d-"))
        newPath += "/d-$p";
      else
        newPath += "/$p";
    }
    if (file != null) newPath += "/~-$file";

    return newPath;
  }

  void remove(String path, {option = "dir"}) {
    CookieManager manager = CookieManager.init();

    manager.removeCookie("${_crtPath(path, option: option)}");
  }

  String getContents(String path) {
    CookieManager manager = CookieManager.init();
    return manager.getCookie("${_crtPath(path, option: "file")}");
  }

  List _listItemsOnWeb() {
    CookieManager manager = CookieManager.init();
    List<String> cookies = manager.getAllCookie();
    List items = [];
    for (String cookie in cookies) {
      List<String> map = cookie.split("=");
      String name = map[0].split("/").last;

      if (name.startsWith("d-")) // if it starts with d then it is a directory.
        items.add(LinuxDirectory(
          "${map[0].replaceAll("d-", "").replaceAll("~-", "")}",
        ));
      else if (name.startsWith("~-")) // if it starts with ~ then it is a file.
        items.add(LinuxFile(
          "${map[0].replaceAll("d-", "").replaceAll("~-", "")}",
        ));
    }

    return items;
  }

  String getCorrectPath(String command, String currentPath) {
    String path;
    if (command.startsWith("/"))
      path = command;
    else {
      path = currentPath + "/" + command;
    }

    return path;
  }
}

extension parentPath on String {
  String getParentPath() {
    List split = this.split("/");
    split.removeLast();
    return split.join("/");
  }
}

extension ownerShip on FileSystemEntity {
  static String? owner;
}
