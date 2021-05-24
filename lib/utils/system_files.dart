import 'dart:convert';

import 'package:flutter/services.dart';

import '../constants.dart';

class SystemFiles {
  SystemFiles._();
  static var jsonData;
  static Future loadJsonData() async {
    jsonData = json.decode(await rootBundle.loadString(configFile));
    return SystemFiles._();
  }

  List getMenuBarApps() {
    return jsonData["menubar-apps"];
  }

  Map getFileIcons() {
    return jsonData["file-icons"];
  }

  String getDirIcon() {
    return jsonData["dir-icon"];
  }
}
