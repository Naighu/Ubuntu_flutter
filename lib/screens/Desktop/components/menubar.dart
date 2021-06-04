import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/app_controller.dart';
import '../../../controllers/system_controller.dart';
import 'menu_icons.dart';
import '../../../utils/system_files.dart';
import '../../../models/app.dart';
import '../../../constants.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  final AppController appController = Get.find<AppController>();

  ///holds the apps to be placed in the menubar
  List? menubarAppsPackageNames;
  late List<App> apps;
  @override
  void initState() {
    super.initState();
    menubarAppsPackageNames = [];
    apps = [];

    /// get the packagenames of the apps to be placed in the menubar
    if (SystemFiles.jsonData == null) {
      SystemFiles.loadJsonData().then((value) {
        setState(() {
          menubarAppsPackageNames = value.getMenuBarApps();
          if (apps.isEmpty) {
            List a = value.getInstalledApps();
            a.forEach((e) => apps.add(App.fromJson(e)));
          }
        });
      });
    } else
      menubarAppsPackageNames = SystemFiles.getObject().getMenuBarApps();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<SystemController>(
        builder: (menuController) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                  right: menuWidth - menuController.menubarWidth.value),
              color: Colors.black.withOpacity(0.6),
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity:
                      menuController.menubarWidth.value == menuWidth ? 1 : 0,
                  child: GetBuilder<AppController>(builder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //default menu icons

                        for (App app in apps)
                          if (menubarAppsPackageNames!
                              .contains(app.packageName))
                            if (appController.appStack
                                    .checkApp(app.packageName) !=
                                -1)
                              MenuIcon(
                                  apps: appController.appStack[appController
                                      .appStack
                                      .checkApp(app.packageName)])
                            else
                              MenuIcon(apps: [app]),

                        //currently opened apps other than the menuapps

                        for (List<App> apps in appController.appStack)
                          if (!menubarAppsPackageNames!
                              .contains(apps[0].packageName))
                            MenuIcon(apps: apps),

                        Spacer(),

                        Tooltip(
                          message: "Show Applications",
                          margin: EdgeInsets.only(left: menuWidth),
                          verticalOffset: -10.0,
                          child: IconButton(
                              padding: const EdgeInsets.only(
                                bottom: defaultPadding * 4,
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.apps, size: 28)),
                        ),
                      ],
                    );
                  })),
            ));
  }
}

extension on List<List<App>> {
  int checkApp(String packageName) {
    for (int i = 0; i < this.length; i++)
      if (this[i][0].packageName == packageName) return i;
    return -1;
  }
}
