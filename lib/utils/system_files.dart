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

  static SystemFiles getObject() {
    return SystemFiles._();
  }

  ///returns the menubar apps packagenames
  List? getMenuBarApps() {
    return jsonData["menubar-apps"];
  }

  //returns the file icons for specific files
  Map? getFileIcons() {
    return jsonData["file-icons"];
  }

  /// Which app should be opened for specific files...
  /// returns the app packagename for the particular file.
  String? getAppPackageNameToOpenFile(String fileName) {
    String ext = fileName.split(".").last;
    Map data = jsonData["file-open-app"];
    if (data.containsKey(ext)) return data[ext];
    return data["*"];
  }

  List? getInstalledApps() => jsonData["installed-apps"];

  ///get the dir icon
  String? getDirIcon() {
    return jsonData["dir-icon"];
  }
}
