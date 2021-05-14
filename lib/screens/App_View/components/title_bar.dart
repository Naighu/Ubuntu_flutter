import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/app_controller.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

PreferredSizeWidget titleBar(BuildContext context, App app, ThemeData theme) {
  AppController controller = Get.find<AppController>();
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
          onTap: () {
            controller.hide(app);
          },
          child: Icon(Icons.minimize, size: 16, color: theme.iconTheme.color)),
      const SizedBox(width: defaultPadding),
      InkWell(
          onTap: () {
            if (app.isMaximized)
              controller.minimize(app, MediaQuery.of(context).size);
            else
              controller.maximize(app, MediaQuery.of(context).size);
          },
          child:
              Icon(Icons.crop_square, size: 16, color: theme.iconTheme.color)),
      const SizedBox(width: defaultPadding),
      Container(
        margin: const EdgeInsets.only(right: defaultPadding),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: InkWell(
            onTap: () {
              debugPrint("close");
              controller.removeApp(app);
            },
            child: Icon(Icons.close, size: 16, color: theme.iconTheme.color)),
      )
    ],
  );
}
