import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import '../../../controllers/system_controller.dart';
import '../../../controllers/app_controller.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

PreferredSizeWidget titleBar(BuildContext context, App app, ThemeData theme,
    {required Function(bool) onScreenSizeChanged,
    required Function() onClose}) {
  AppController controller = Get.find<AppController>();
  final menu = Get.find<SystemController>();
  return AppBar(
    backgroundColor: Color(0xFF161616),
    toolbarHeight: topAppBarHeight - 5.0,
    centerTitle: true,
    title: Text(
      app.name,
      style: theme.textTheme.headline4,
    ),
    actions: [
      InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            menu.menubarWidth.value = menuWidth;
            controller.hide(app);
          },
          child: SvgPicture.asset("assets/window/window-minimize.svg",
              height: 20, color: theme.iconTheme.color)),
      const SizedBox(width: defaultPadding),
      InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (app.isMaximized) {
              controller.minimize(app);
            } else {
              controller.maximize(
                app,
                MediaQuery.of(context).size,
              );
            }
            onScreenSizeChanged(!app.isMaximized);
          },
          child: SvgPicture.asset(
              app.isMaximized
                  ? "assets/window/window-restore.svg"
                  : "assets/window/window-maximize.svg",
              height: 16,
              width: 16,
              color: theme.iconTheme.color)),
      const SizedBox(width: defaultPadding),
      Container(
        margin: const EdgeInsets.only(right: defaultPadding),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              onClose();
            },
            child: SvgPicture.asset("assets/window/window-close.svg",
                color: theme.iconTheme.color)),
      )
    ],
  );
}
