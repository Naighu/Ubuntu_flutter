import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/gedit/gedit.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:ubuntu/models/file.dart';

class FileExplorer extends StatefulWidget {
  final String dir;

  const FileExplorer({Key key, @required this.dir}) : super(key: key);
  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  String dir;
  @override
  void initState() {
    super.initState();
    dir = widget.dir;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileController>(
        assignId: true,
        id: dir,
        init: FileController(context),
        builder: (controller) {
          return Container(
            color: Theme.of(context).backgroundColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Wrap(
              runSpacing: 20.0,
              spacing: 30.0,
              children: [
                for (MyFile file in controller.getFiles(dir))
                  GestureDetector(
                    onDoubleTap: () {
                      _onDoubleTap(file);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        file.icon,
                        Text(
                          file.fileName,
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
        });
  }

  void _onDoubleTap(MyFile file) {
    final controller = Get.find<AppController>();
    if (file.file is File)
      controller.appStack.add(App(
          icon: "assets/app_icons/gedit.png",
          name: file.fileName,
          context: context,
          packageName: "gedit",
          child: Gedit(
            path: file.file.path,
          )));
    else
      setState(() {
        dir = file.file.path;
      });
  }
}
