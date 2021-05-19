import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/bash_commands/command_packages.dart';
import 'package:ubuntu/models/file.dart';

import '../constants.dart';

class FileController extends GetxController {
  final BuildContext context;
  FileController(this.context) {
    _getFiles();
  }
  void changeOffset(MyFile file, Offset offset) {
    file.setOffset = offset;
    update();
  }

  List<MyFile> _files = [];
  List<MyFile> get files => _files;
  void _getFiles() {
    List items = Ls().ls(rootDir);

    for (var item in items) {
      _files.add(_file(item));
    }
  }

  void add(FileSystemEntity item) {
    _files.add(_file(item));
    update();
  }

  void delete(FileSystemEntity item) {
    _files.clear();
    _getFiles();
    print(_files.length);
    update();
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
