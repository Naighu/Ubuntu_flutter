import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/controllers/desktop_controller.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:get/get.dart';
import 'package:ubuntu/models/file.dart';
import 'package:ubuntu/screens/Desktop/components/file_stram.dart';
import 'package:ubuntu/screens/Desktop/components/file_ui.dart';
import 'package:ubuntu/utils/show_on_rightclick_menu.dart';

import '../../screens/App_View/app_view.dart';
import 'components/appbar.dart';
import 'components/menubar.dart';

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
          _onPointerDown(context, event);
        },
        onPointerUp: (event) {
          if (entry != null && entry.mounted) entry?.remove();
        },
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: Image.asset(
                  "assets/wallpaper/wall-2.png",
                ).image,
                fit: BoxFit.cover,
              )),
            ),
            Positioned(
                left: 0,
                width: menuWidth,
                height: size.height,
                child: MenuBar()),
            GetBuilder<FileController>(
                init: FileController(context),
                builder: (controller) {
                  return Stack(
                    children: [
                      for (MyFile file in controller.files)
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

  Future<void> _onPointerDown(context, PointerDownEvent event) async {
    // Check if right mouse button clicked
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      final overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      await MouseRightClick(event.position & Size(48, 48.0), overlay.size, [
        MenuOptions.newFolder,
        MenuOptions.newFile,
        MenuOptions.openTerminal,
        MenuOptions.settings,
      ]).showOnRightClickMenu(context, onPressed: (option) {
        if (option == MenuOptions.newFolder)
          Mkdir().mkdir(Get.find<FileController>(), rootDir, "Nihal");
        else if (option == MenuOptions.newFile)
          Touch().touch(Get.find<FileController>(), rootDir, "file.txt");
        else if (option == MenuOptions.openTerminal) {
          controller.appStack.add(getApps(context)[3]);
        }
      });
    }
  }
}
