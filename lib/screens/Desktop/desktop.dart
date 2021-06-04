import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/utils/Rightclick/evaluate.dart';

import '../../utils/Rightclick/show_on_rightclick_menu.dart';
import '../../System_Apps/App_View/app_view.dart';
import '../../constants.dart';
import '../../controllers/system_controller.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/file_controller.dart';
import '../../models/app.dart';
import 'components/file_ui.dart';
import 'components/appbar.dart';
import 'components/menubar.dart';

class Desktop extends StatelessWidget {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    OverlayEntry? entry;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: taskManger(context, (e) {
        if (entry == null || !entry!.mounted) {
          entry = e;
          Overlay.of(context)!.insert(e);
        } else
          entry?.remove();
      }),
      body: Listener(
        onPointerDown: (event) {
          //mouse  right click event
          onPointerDown(context, event);
        },
        onPointerUp: (event) {
          // removing the status menu pop up overlay
          if (entry != null && entry!.mounted) entry?.remove();
        },
        child: Stack(
          children: [
            // Desktop wallpeper

            GetX<SystemController>(
              init: SystemController(),
              builder: (wallpaper) => Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: Image.asset(
                          "assets/wallpapers/${wallpaper.desktopWallpaper.value}")
                      .image,
                  fit: BoxFit.cover,
                )),
              ),
            ),

            // menu bar

            Positioned(
                left: 0,
                width: menuWidth,
                height: size.height,
                child: MenuBar()),

            //listing the desktop files and folders

            GetBuilder<FileController>(
                assignId: true,
                id: rootDir,
                init: FileController(),
                builder: (controller) {
                  return FileUi(files: controller.getFiles(rootDir));
                }),

            // shows the opened apps in the window

            GetBuilder<AppController>(builder: (_) {
              return Stack(children: [
                for (List<App> apps in controller.appStack)
                  for (App app in apps)
                    AppView(key: Key(app.pid.toString()), app: app)
              ]);
            })
          ],
        ),
      ),
    );
  }

  Future<void> onPointerDown(context, PointerDownEvent event) async {
    // Check if right mouse button clicked
    await MouseClick(options: [
      MenuOptions.newFolder,
      MenuOptions.newFile,
      MenuOptions.paste,
      MenuOptions.openTerminal,
      MenuOptions.settings,
    ]).showOnRightClickMenu(context, event, Evaluate(currentPath: rootDir));
  }
}
