import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/models/file.dart';

class FileStream {
  List<MyFile> _myFiles = [];
  Stream<List<MyFile>> listFolders(String dir, Size size) async* {
    final list = Ls();

    while (true) {
      List<MyFile> files = [];
      List items = list.ls(dir);
      for (var item in items) {
        files.add(MyFile(
            icon: item is Directory
                ? Image.asset("assets/system/folder.png")
                : Image.asset(
                    "assets/app_icons/gedit.png",
                    height: 50,
                    width: 50,
                  ),
            file: item,
            fileName: item.path.split("/").last,
            offset: Offset(
                Random()
                    .nextInt((size.width - menuWidth - 100).toInt())
                    .toDouble(),
                Random()
                    .nextInt((size.height - topAppBarHeight - 100).toInt())
                    .toDouble())));
      }
      if (files.isEmpty) {
        _myFiles.clear();
        yield _myFiles;
      } else if (_myFiles.length > files.length) {
        deleteFile(files);
        yield _myFiles;
      } else if (_myFiles.length < files.length) {
        addFile(files);
        yield _myFiles;
      } else {
        if (renameFile(files)) ;
        yield _myFiles;
      }

      await Future.delayed(Duration(seconds: 1));
    }
  }

  bool renameFile(List files) {
    //if a file is renamed

    int index = _myFiles.nameChange(files);

    if (index != -1) {
      _myFiles.removeAt(index);
      _myFiles.add(files[index]);
      return true;
    }
    return false;
  }

  void addFile(List files) {
    //if a new file is created
    for (int i = _myFiles.length; i < files.length; i++) _myFiles.add(files[i]);
  }

  void deleteFile(List files) {
    List present = [];

    for (int i = 0; i < _myFiles.length; i++) {
      for (int j = 0; j < files.length; j++) {
        if (_myFiles[i].fileName == files[j].fileName) {
          present.add(i);
          break;
        }
      }
    }
    int deletedIndex = _myFiles.length - 1;
    for (int i = 0; i < present.length; i++) {
      if (present[i] != i) {
        deletedIndex = i;
        break;
      }
    }
    _myFiles.removeAt(deletedIndex);
  }
}

extension on List {
  int nameChange(List list) {
    for (int i = 0; i < this.length; i++) {
      if (this[i].fileName != list[i].fileName) return i;
    }
    return -1;
  }
}