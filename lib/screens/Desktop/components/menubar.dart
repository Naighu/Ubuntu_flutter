import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu/controllers/app_controller.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

class MenuBar extends StatefulWidget {
  final Size size;
  MenuBar({Key key, this.size}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  List<App> _apps;
  @override
  void initState() {
    super.initState();

    _apps = getApps(widget.size);
  }

  @override
  Widget build(BuildContext context) {
    print("Menubar rebuilding");
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF461013), Color(0xFF1A011A)])),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (App app in _apps)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.7),
              child: Tooltip(
                message: app.name,
                margin: EdgeInsets.only(left: menuWidth),
                verticalOffset: -10.0,
                child: Container(
                  color: context.read<AppController>().appStack.contains(app)
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  child: Stack(
                    children: [
                      // selected app icon dot
                      if (context.read<AppController>().appStack.contains(app))
                        Container(
                            height: 4.0,
                            width: 4.0,
                            margin: const EdgeInsets.only(top: 25.0, left: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle)),

                      TextButton(
                        onPressed: () {
                          if (!context
                              .read<AppController>()
                              .appStack
                              .contains(app)) {
                            // this.setState(() {});
                            context.read<AppController>().addApp(app);
                          }
                        },
                        child: SizedBox(
                          height: 50.0,
                          width: 30.0,
                          child: Image.asset(
                            app.icon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding * 4),
            child: Tooltip(
              message: "Show Applications",
              margin: EdgeInsets.only(left: menuWidth),
              verticalOffset: -10.0,
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.apps, size: 28)),
            ),
          )
        ],
      ),
    );
  }
}
