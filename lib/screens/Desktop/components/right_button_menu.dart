import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apps/terminal/commands/bash_commands/make_dir.dart';
import '../../../Apps/terminal/commands/bash_commands/make_file.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/file_controller.dart';
import '../../../models/app.dart';
import '../../../utils/dialogBox.dart';
import '../../../utils/show_on_rightclick_menu.dart';

import '../../../constants.dart';

Future<void> onPointerDown(context, PointerDownEvent event) async {
  final controller = Get.find<AppController>();
  // Check if right mouse button clicked
  if (event.kind == PointerDeviceKind.mouse &&
      event.buttons == kSecondaryMouseButton) {
    final overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
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
    App? terminalApp = controller.getAppByPackageName("terminal");
    controller.addApp(terminalApp, addByIgnoringDuplicates: true);
  } else if (option == MenuOptions.settings) {
    App? settingsApp = controller.getAppByPackageName("settings");

    controller.addApp(settingsApp, addByIgnoringDuplicates: true);
  }
}
