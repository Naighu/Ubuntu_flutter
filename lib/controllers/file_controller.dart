import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Apps/terminal/commands/bash_commands/command_packages.dart';
import '../models/file.dart';

class FileController extends GetxController {
  RxList? fileExplorStack; //used by the file explorer app
  FileController() {
    fileExplorStack = [].obs;
  }
  void changeOffset(MyFile file, Offset offset) {
    file.setOffset = offset;
    update();
  }

  List<MyFile> getFiles(String? dir) {
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
    update([
      split.join("/"),
      "explorer"
    ]); //"explorer" is added inorder to get the update to the file Explorer app.
  }

  MyFile _file(FileSystemEntity item) => MyFile(
      file: item,
      fileName: item.path.split("/").last,
      offset: Offset(
          Random().nextInt(90).toDouble(), Random().nextInt(90).toDouble()));
}
