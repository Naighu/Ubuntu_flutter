import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/bash_commands/command_packages.dart';
import 'package:ubuntu/models/file.dart';

class FileController extends GetxController {
  final BuildContext context;
  FileController(this.context) {}
  void changeOffset(MyFile file, Offset offset) {
    file.setOffset = offset;
    update();
  }

  List<MyFile> getFiles(String dir) {
    List<MyFile> files = [];
    final items = Ls().ls(dir);
    for (var item in items) {
      files.add(_file(item));
    }
    return files;
  }

  void updateUi(String path) {
    var split = path.split("/");
    split.removeLast();
    update([split.join("/")]);
  }

  MyFile _file(FileSystemEntity item) => MyFile(
      icon: item is Directory
          ? Image.asset("assets/system/folder.png")
          : Image.asset(
              "assets/app_icons/gedit.png",
              height: 50,
              width: 50,
            ),
      context: context,
      file: item,
      fileName: item.path.split("/").last,
      offset: Offset(
          Random().nextInt(90).toDouble(), Random().nextInt(90).toDouble()));
}
