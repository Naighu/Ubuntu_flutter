import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/app_controller.dart';
import '../../../models/app.dart';

import '../../../constants.dart';

class MenuIcon extends StatelessWidget {
  final App? app;

  MenuIcon({Key? key, this.app}) : super(key: key);
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: app!.name,
        margin: EdgeInsets.only(left: menuWidth),
        verticalOffset: -10.0,
        child: Container(
          color: appController.appStack.check(app)
              ? Colors.white.withOpacity(0.3)
              : Colors.transparent,
          child: Stack(
            children: [
              // selected app icon dot
              if (appController.appStack.check(app))
                Container(
                    height: 4.0,
                    width: 4.0,
                    margin: const EdgeInsets.only(top: 25.0, left: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle)),

              TextButton(
                onPressed: () {
                  _onPressed(appController, app);
                },
                child: SizedBox(
                  height: 50.0,
                  width: 30.0,
                  child: Image.asset(
                    app!.icon,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// if the app is not present in the [appStack] then it will add the app to the [appStack]
  void _onPressed(AppController appController, App? app) {
    if (!appController.appStack.check(app))
      appController.addApp(app, params: getParams(app!));
    else
      appController.show(app!.packageName);
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
        params["url"] =
            "https://github1s.com/vivek9patel/vivek9patel.github.io/blob/HEAD/src/components/ubuntu.js";
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

extension on List {
  bool check(App? app) {
    for (App? a in this) if (a!.packageName == app!.packageName) return true;

    return false;
  }
}
