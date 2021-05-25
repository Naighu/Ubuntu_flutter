import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/controllers/desktop_controller.dart';
import 'package:ubuntu/models/app.dart';

class SettingsPage extends StatefulWidget {
  final App app;
  final Map params;

  const SettingsPage({Key key, this.app, this.params}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> _wallpapers = [
    "wall-1.jpg",
    "wall-2.png",
    "wall-3.jpg",
    "wall-4.jpg",
    "wall-5.jpg",
    "wall-6.png",
    "wall-7.png",
    "wall-8.jpg"
  ];
  final DesktopController desktopController = Get.find<DesktopController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: LayoutBuilder(builder: (context, constraints) {
        return RawScrollbar(
          isAlwaysShown: true,
          thumbColor: Colors.white,
          radius: Radius.circular(10.0),
          child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: Column(
                children: [
                  Container(
                      height: constraints.maxHeight * 0.4,
                      width: constraints.maxWidth * 0.4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.asset(
                                "assets/wallpapers/minified/${desktopController.desktopWallpaper.value}",
                              ).image,
                              fit: BoxFit.cover))),
                  const Divider(
                    color: Colors.black,
                  ),
                  Container(
                    width: constraints.maxWidth,
                    alignment: Alignment.center,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      children: [
                        for (String name in _wallpapers)
                          InkWell(
                            onTap: () {
                              setState(() {
                                desktopController.desktopWallpaper.value = name;
                              });
                            },
                            child: Container(
                                height: constraints.maxHeight * 0.35,
                                width: constraints.maxWidth * 0.25,
                                margin: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: desktopController
                                                    .desktopWallpaper.value ==
                                                name
                                            ? Colors.orange
                                            : Colors.transparent,
                                        width: 2.0),
                                    image: DecorationImage(
                                        image: Image.asset(
                                          "assets/wallpapers/minified/$name",
                                        ).image,
                                        fit: BoxFit.cover))),
                          )
                      ],
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }
}
