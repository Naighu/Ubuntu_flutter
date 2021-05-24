import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/desktop_controller.dart';
import 'package:ubuntu/screens/Desktop/components/menu_icons.dart';
import 'package:ubuntu/utils/system_files.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  final AppController appController = Get.find<AppController>();
  List<App> _apps;
  List menubarAppsPackageNames;
  @override
  void initState() {
    super.initState();
    menubarAppsPackageNames = [];
    _apps = getApps();
    SystemFiles.loadJsonData().then((value) {
      setState(() {
        menubarAppsPackageNames = value.getMenuBarApps();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<DesktopController>(
        builder: (menuController) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                  right: menuWidth - menuController.menubarWidth.value),
              color: Colors.black.withOpacity(0.6),
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity:
                      menuController.menubarWidth.value == menuWidth ? 1 : 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //default menu icons
                      for (App app in _apps)
                        if (menubarAppsPackageNames.contains(app.packageName))
                          MenuIcon(app: app),
                      //currently opened apps other than the menuapps
                      for (App app in appController.appStack)
                        if (!menubarAppsPackageNames.contains(app.packageName))
                          MenuIcon(app: app),

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

extension on RxList {
  bool checkPackageName(String packageName) {
    for (App a in this) if (a.packageName == packageName) return true;
    return false;
  }
}
