import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/models/app.dart';

import '../../constants.dart';
import '../../screens/App_View/app_view.dart';
import 'components/appbar.dart';
import 'components/menubar.dart';

class Desktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: desktopAppBar(theme),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(
                "assets/wallpaper/wall-2.png",
              ).image,
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
              left: 0,
              width: menuWidth,
              height: size.height,
              child: MenuBar(size: size)),
          for (App app in context.watch<AppController>().appStack)
            AppView(app: app)
        ],
      ),
    );
  }
}
