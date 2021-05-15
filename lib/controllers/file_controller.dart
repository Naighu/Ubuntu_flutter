import 'package:get/get.dart';
import 'package:ubuntu/models/file.dart';

class FileController extends GetxController {
  final List<MyFile> _myFiles = [];

  List<MyFile> get myFile => _myFiles.obs;
}
