import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/desktop_controller.dart';
import 'package:ubuntu/models/app.dart';

import '../../../constants.dart';

class MenuIcon extends StatefulWidget {
  final App app;

  const MenuIcon({Key key, this.app}) : super(key: key);

  @override
  _MenuIconState createState() => _MenuIconState();
}

class _MenuIconState extends State<MenuIcon> {
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.app.name,
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
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle)),

            TextButton(
              onPressed: () {
                _onPressed(appController, widget.app);
              },
              child: SizedBox(
                height: 50.0,
                width: 30.0,
                child: Image.asset(
                  widget.app.icon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed(AppController appController, App app) {
    print("Pressed on app");

    if (!appController.appStack.check(app)) {
      print("Pressed on if");
      appController.appStack.add(app);
    } else {
      print("Pressed on else");

      appController.show(app.packageName);
    }
  }
}

extension on RxList {
  bool check(App app) {
    // ignore: invalid_use_of_protected_member
    for (App a in this.value) if (a.packageName == app.packageName) return true;

    return false;
  }
}
