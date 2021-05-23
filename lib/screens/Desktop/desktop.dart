import 'package:flutter/material.dart';
import 'package:ubuntu/System_Apps/App_View/app_view.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/controllers/desktop_controller.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:get/get.dart';
import 'package:ubuntu/models/file.dart';

import 'Files/file_ui.dart';
import 'components/appbar.dart';
import 'components/menubar.dart';
import 'components/right_button_menu.dart';

class Desktop extends StatelessWidget {
  final menuController = Get.put(DesktopController());
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    OverlayEntry entry;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: desktopAppBar(context, (e) {
        if (entry == null || !entry.mounted) {
          entry = e;
          Overlay.of(context).insert(e);
        } else
          entry?.remove();
      }),
      body: Listener(
        onPointerDown: (event) {
          onPointerDown(context, event);
        },
        onPointerUp: (event) {
          if (entry != null && entry.mounted) entry?.remove();
        },
        child: Stack(
          children: [
            GetX<DesktopController>(
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
            Positioned(
                left: 0,
                width: menuWidth,
                height: size.height,
                child: MenuBar()),
            GetBuilder<FileController>(
                assignId: true,
                id: rootDir,
                init: FileController(),
                builder: (controller) {
                  return Stack(
                    children: [
                      for (MyFile file in controller.getFiles(context, rootDir))
                        FileUi(
                          key: Key(file.file.path),
                          file: file,
                          controller: controller,
                        ),
                    ],
                  );
                }),
            Obx(() {
              return Stack(children: [
                for (App app in controller.appStack)
                  AppView(key: Key(app.name), app: app)
              ]);
            })
          ],
        ),
      ),
    );
  }
}
