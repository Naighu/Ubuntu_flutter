import 'package:flutter/material.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/desktop_controller.dart';
import 'package:ubuntu/screens/Desktop/components/menu_icons.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

class MenuBar extends StatelessWidget {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    print("Menubar rebuilding");
    List<App> _apps = getApps(context);
    return GetX<DesktopController>(
        builder: (menuController) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                  right: menuWidth - menuController.menubarWidth.value),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF461013), Color(0xFF1A011A)])),
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity:
                      menuController.menubarWidth.value == menuWidth ? 1 : 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //default menu icons
                      for (App app in _apps) MenuIcon(app: app),
                      //currently opened apps other than the menuapps
                      for (App app in appController.appStack)
                        if (!_apps.check(app)) MenuIcon(app: app),

                      Spacer(),

                      Tooltip(
                        message: "Show Applications",
                        margin: EdgeInsets.only(left: menuWidth),
                        verticalOffset: -10.0,
                        child: IconButton(
                            padding: const EdgeInsets.only(
                              bottom: defaultPadding * 4,
                            ),
                            onPressed: () {
                              print("Pressed");
                            },
                            icon: Icon(Icons.apps, size: 28)),
                      ),
                    ],
                  )),
            ));
  }
}

extension on List {
  bool check(App app) {
    for (App a in this) if (a.packageName == app.packageName) return true;
    return false;
  }
}
