import 'package:flutter/material.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

class MenuBar extends StatefulWidget {
  final double menuWidth;

  MenuBar({Key key, this.menuWidth}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF461013), Color(0xFF1A011A)])),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (App app in getApps(size))
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.7),
              child: Tooltip(
                message: app.name,
                margin: EdgeInsets.only(left: widget.menuWidth),
                verticalOffset: -10.0,
                child: Container(
                  color: app.isSelected
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  child: Stack(
                    children: [
                      // selected app icon dot
                      if (app.isSelected)
                        Container(
                            height: 4.0,
                            width: 4.0,
                            margin: const EdgeInsets.only(top: 25.0, left: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle)),

                      TextButton(
                        onPressed: () {
                          this.setState(() {
                            app.isSelected = !app.isSelected;
                          });
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
              margin: EdgeInsets.only(left: widget.menuWidth),
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
