import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/app_controller.dart';
import '../../../models/app.dart';

import '../../../constants.dart';

class MenuIcon extends StatefulWidget {
  final App? app;

  const MenuIcon({Key? key, this.app}) : super(key: key);

  @override
  _MenuIconState createState() => _MenuIconState();
}

class _MenuIconState extends State<MenuIcon> {
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: widget.app!.name,
        margin: EdgeInsets.only(left: menuWidth),
        verticalOffset: -10.0,
        child: Container(
          color: appController.appStack.check(widget.app)
              ? Colors.white.withOpacity(0.3)
              : Colors.transparent,
          child: Stack(
            children: [
              // selected app icon dot
              if (appController.appStack.check(widget.app))
                Container(
                    height: 4.0,
                    width: 4.0,
                    margin: const EdgeInsets.only(top: 25.0, left: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle)),

              TextButton(
                onPressed: () {
                  _onPressed(appController, widget.app);
                },
                child: SizedBox(
                  height: 50.0,
                  width: 30.0,
                  child: Image.asset(
                    widget.app!.icon,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _onPressed(AppController appController, App? app) {
    print("Pressed on app");

    if (!appController.appStack.check(app)) {
      print("Pressed on if");
      appController.addApp(app, params: getParams(app!));
    } else {
      print("Pressed on else");

      appController.show(app!.packageName);
    }
  }

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
    // ignore: invalid_use_of_protected_member
    for (App? a in this) if (a!.packageName == app!.packageName) return true;

    return false;
  }
}
