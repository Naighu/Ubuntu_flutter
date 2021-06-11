import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/app_controller.dart';
import '../../../models/app.dart';

import '../../../constants.dart';

class MenuIcon extends StatelessWidget {
  final List<App> apps;

  MenuIcon({Key? key, required this.apps}) : super(key: key);
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: apps[0].name,
        margin: EdgeInsets.only(left: menuWidth),
        verticalOffset: -10.0,
        child: Container(
          color: appController.appStack.check(apps[0])
              ? Colors.white.withOpacity(0.3)
              : Colors.transparent,
          child: Stack(
            children: [
              // selected app icon dot

              Padding(
                padding: EdgeInsets.only(top: (24.0 - 3 * (apps.length)).abs()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (App app in apps)
                      if (appController.appStack.check(app))
                        Container(
                            height: 4.0,
                            width: 4.0,
                            margin: const EdgeInsets.only(left: 8.0, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle)),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  _onPressed(appController, apps[0]);
                },
                child: SizedBox(
                  height: 50.0,
                  width: 30.0,
                  child: Image.asset(
                    apps[0].icon,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// if the app is not present in the [appStack] then it will add the app to the [appStack]
  void _onPressed(AppController appController, App app) {
    if (!appController.appStack.check(app))
      appController.addApp(app, params: getParams(app));
    else
      appController.show(app);
  }

  /// get the parameters to pass to the app when app's loading..
  Map getParams(App app) {
    Map params = {};
    switch (app.packageName) {
      case "spottify":
        params["url"] =
            "https://open.spotify.com/embed/playlist/37i9dQZEVXbLZ52XmnySJg";
        break;
      case "vscode":
        params["url"] = "https://github1s.com/naighu/naighu.github.io/#/";
        break;
      case "chrome":
        params["url"] = "https://www.google.com/webhp?igu=1";
        break;
      case "explorer":
        params["dir"] = rootDir;
        break;
    }
    return params;
  }
}

extension on List<List<App>> {
  bool check(App app) {
    for (List<App> apps in this)
      for (App a in apps) if (a.packageName == app.packageName) return true;

    return false;
  }
}
