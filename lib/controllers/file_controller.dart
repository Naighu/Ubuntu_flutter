import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';
import 'package:ubuntu/models/file.dart';

class FileController extends GetxController {
  static List<MyFile> _myFiles = [];

  static Stream<List<MyFile>> listFolders(String dir) async* {
    final list = Ls();

    while (true) {
      List<MyFile> files = [];
      List items = list.ls(dir);

      for (var item in items) {
        files.add(MyFile(
            icon: Image.asset("assets/system/folder.png"),
            file: item,
            fileName: item.path.split("/").last));
      }
      int index = _myFiles.nameChange(files);

      //if a file is deleted
      if (_myFiles.length > files.length) {
        _myFiles.removeAt(index);

        yield _myFiles;
      }
      //if a file is renamed
      else if (index != -1) {
        print(index);
        _myFiles.removeAt(index);
        _myFiles.add(files[index]);
        yield _myFiles;
      } else if (_myFiles.length < files.length) {
        //if a new file is created
        for (int i = _myFiles.length; i < files.length; i++)
          _myFiles.add(files[i]);
        yield _myFiles;
      }

      await Future.delayed(Duration(seconds: 1));
    }
  }

  void changeOffset(MyFile file, Offset offset) {
    file.offset = offset;
    update();
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
