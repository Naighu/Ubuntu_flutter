import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          child: Icon(Icons.minimize, size: 16, color: theme.iconTheme.color)),
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
          child: Icon(
              app.isMaximized ? FontAwesomeIcons.clone : Icons.crop_square,
              size: 16,
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
            child: Icon(Icons.close, size: 16, color: theme.iconTheme.color)),
      )
    ],
  );
}
