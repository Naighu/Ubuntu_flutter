import 'dart:io';

import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/controllers/system_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:ubuntu/models/file.dart';
import 'package:ubuntu/utils/Rightclick/show_on_rightclick_menu.dart';

import '../dialogBox.dart';

/// Evalation for the option clicked by the user on rightclick..

class Evaluate {
  String currentPath;
  MyFile? file;
  Function(MenuOptions)? onPressed;
  Evaluate({required this.currentPath, this.file, this.onPressed});

  void evaluate(context, menuItem) {
    final appController = Get.find<AppController>();
    final FileController fileController = Get.find<FileController>();
    final SystemController systemController = Get.find<SystemController>();

    switch (menuItem) {
      case 1:
        if (onPressed != null) onPressed!(MenuOptions.newFolder);

        DialogBox(
            title: "New Folder Name",
            bodyType: BodyType.textField,
            onOk: (name) {
              Mkdir().mkdir(Get.find<FileController>(), currentPath, "$name");
            }).show(context);
        break;

      case 2:
        if (onPressed != null) onPressed!(MenuOptions.newFile);
        DialogBox(
            title: "New File Name",
            bodyType: BodyType.textField,
            onOk: (name) {
              Touch().touch(Get.find<FileController>(), currentPath, "$name");
            }).show(context);

        break;

      case 3:
        if (onPressed != null) onPressed!(MenuOptions.openTerminal);
        App? terminalApp = appController.getAppByPackageName("terminal");

        appController.addApp(terminalApp, params: {"pwd": currentPath});
        break;

      case 4:
        if (onPressed != null) onPressed!(MenuOptions.settings);
        App settingsApp = appController.getAppByPackageName("settings")!;

        appController.addApp(
          settingsApp,
        );
        break;

      case 5:
        if (onPressed != null) onPressed!(MenuOptions.delete);
        if (file!.file is LinuxFile)
          Rm().rm(fileController, currentPath, file!.fileName!);
        else
          Rmdir().rmdir(fileController, currentPath, file!.fileName!);

        break;

      case 6:
        if (onPressed != null) onPressed!(MenuOptions.open);
        if (file!.file is File) {
          App? app = appController.getAppByPackageName("gedit");
          appController.addApp(app, params: {"path": file!.file!.path});
        } else {
          App? app = appController.getAppByPackageName("explorer");
          appController.addApp(app, params: {"dir": file!.file!.path});
        }
        break;

      case 7:
        if (onPressed != null) onPressed!(MenuOptions.copy);
        systemController.clipboard = file;
        break;

      case 8:
        if (systemController.clipboard != null) {
          if (onPressed != null) onPressed!(MenuOptions.paste);

          Cp().cp(
              fileController,
              systemController.clipboard!.file!.path.getParentPath(),
              systemController.clipboard!.fileName!,
              currentPath,
              systemController.clipboard!.fileName!);
        }
        break;
    }
  }
}
