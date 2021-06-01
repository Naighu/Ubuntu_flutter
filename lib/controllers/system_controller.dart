import 'package:get/get.dart';
import 'package:ubuntu/models/file.dart';
import '../constants.dart';

class SystemController extends GetxController {
  final menubarWidth = menuWidth.obs;
  final menubarStack = menuWidth.obs;
  final desktopWallpaper = "wall-2.png".obs;
  MyFile? clipboard;
}
