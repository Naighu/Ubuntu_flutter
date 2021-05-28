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

  static getObject() {
    return SystemFiles._();
  }

  List? getMenuBarApps() {
    return jsonData["menubar-apps"];
  }

  Map? getFileIcons() {
    return jsonData["file-icons"];
  }

  String? getAppPackageNameToOpenFile(String fileName) {
    String ext = fileName.split(".").last;
    Map data = jsonData["file-open-app"];
    if (data.containsKey(ext)) return data[ext];
    return data["*"];
  }

  String? getDirIcon() {
    return jsonData["dir-icon"];
  }
}
