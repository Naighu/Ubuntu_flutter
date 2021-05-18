import 'dart:io';

import "package:flutter/material.dart";

class MyFile {
  final Image icon;
  final FileSystemEntity file;
  final String fileName;
  final BuildContext context;
  Offset _offset;
  Offset get offset => _getOffset;
  MyFile(
      {this.icon,
      this.file,
      this.fileName,
      @required this.context,
      Offset offset}) {
    _offset = offset;
  }
  get _getOffset {
    Size size = MediaQuery.of(context).size;
    final a = Offset(
        (_offset.dx / 100) * size.width, (_offset.dy / 100) * size.height);

    return a;
  }

  set setOffset(Offset newOffset) {
    Size totalSize = MediaQuery.of(context).size;
    _offset = Offset((newOffset.dx / totalSize.width) * 100,
        (newOffset.dy / totalSize.height) * 100);
  }
}
