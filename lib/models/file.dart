import 'dart:io';

import "package:flutter/material.dart";
import 'package:get/get.dart';

class MyFile {
  final FileSystemEntity? file;
  final String? fileName;
  Offset? _offset;
  Offset get offset => _getOffset;
  MyFile({this.file, this.fileName, Offset? offset}) {
    _offset = offset;
  }
  get _getOffset {
    Size size = Get.size;
    final a = Offset(
        (_offset!.dx / 100) * size.width, (_offset!.dy / 100) * size.height);

    return a;
  }

  set setOffset(Offset newOffset) {
    Size totalSize = Get.size;
    _offset = Offset((newOffset.dx / totalSize.width) * 100,
        (newOffset.dy / totalSize.height) * 100);
  }
}
