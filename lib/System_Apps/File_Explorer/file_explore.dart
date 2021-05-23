import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/gedit/gedit.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:ubuntu/models/file.dart';

import '../../constants.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        toolbarHeight: 30.0 + defaultPadding,
        elevation: 0,
        leadingWidth: 30.0 + defaultPadding,
        centerTitle: true,
        title: Text(dir, style: Theme.of(context).textTheme.subtitle1),
        leading: Padding(
          padding:
              const EdgeInsets.only(left: defaultPadding, top: defaultPadding),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).accentColor)),
              onPressed: _onBackPressed,
              child: Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: GetBuilder<FileController>(
          autoRemove: false,
          id: "explorer",
          builder: (controller) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Wrap(
                runSpacing: 20.0,
                spacing: 30.0,
                children: [
                  for (MyFile file in controller.getFiles(context, dir))
                    GestureDetector(
                      onDoubleTap: () {
                        _onDoubleTap(context, file);
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
          }),
    );
  }

  void _onDoubleTap(context, MyFile file) {
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

  void _onBackPressed() {
    final split = dir.split("/");
    print("Greater than ${split.length}");
    if (split.length > 2) {
      setState(() {
        split.removeLast();
        dir = split.join("/");
      });
    }
  }
}
