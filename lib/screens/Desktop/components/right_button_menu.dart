import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/bash_commands/make_dir.dart';
import 'package:ubuntu/Apps/terminal/commands/bash_commands/make_file.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:ubuntu/utils/dialogBox.dart';
import 'package:ubuntu/utils/show_on_rightclick_menu.dart';

import '../../../constants.dart';

Future<void> onPointerDown(context, PointerDownEvent event) async {
  final controller = Get.find<AppController>();
  // Check if right mouse button clicked
  if (event.kind == PointerDeviceKind.mouse &&
      event.buttons == kSecondaryMouseButton) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    await MouseRightClick(event.position & Size(48, 48.0), overlay.size, [
      MenuOptions.newFolder,
      MenuOptions.newFile,
      MenuOptions.openTerminal,
      MenuOptions.settings,
    ]).showOnRightClickMenu(context, onPressed: (option) {
      evaluate(context, option, controller);
    });
  }
}

void evaluate(context, MenuOptions option, AppController controller) {
  if (option == MenuOptions.newFolder)
    DialogBox(
        title: "New Folder Name",
        bodyType: BodyType.textField,
        onOk: (name) {
          Mkdir().mkdir(Get.find<FileController>(), rootDir, "$name");
        }).show(context);
  else if (option == MenuOptions.newFile)
    DialogBox(
        title: "New File Name",
        bodyType: BodyType.textField,
        onOk: (name) {
          Touch().touch(Get.find<FileController>(), rootDir, "$name");
        }).show(context);
  else if (option == MenuOptions.openTerminal) {
    App terminalApp = getApps(context)[3];
    if (!controller.appStack.checkPackageName(
        terminalApp.packageName)) //if terminal is already opened or not
      controller.appStack.add(terminalApp);
  } else if (option == MenuOptions.settings) {
    App settingsApp = getApps(context)[5];
    if (!controller.appStack.checkPackageName(
        settingsApp.packageName)) //if terminal is already opened or not
      controller.appStack.add(settingsApp);
  }
}

extension on RxList {
  bool checkPackageName(String packageName) {
    for (App a in this) if (a.packageName == packageName) return true;
    return false;
  }
}
