import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/models/file.dart';

class FileController extends GetxController {
  void changeOffset(MyFile file, Offset offset) {
    file.offset = offset;
    update();
  }
}
