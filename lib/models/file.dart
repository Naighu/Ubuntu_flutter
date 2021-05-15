import 'dart:io';

import "package:flutter/material.dart";

class MyFile {
  final Image icon;
  final FileSystemEntity file;
  final String fileName;
  Offset offset;
  MyFile({this.icon, this.file, this.fileName, this.offset = Offset.zero});
}
