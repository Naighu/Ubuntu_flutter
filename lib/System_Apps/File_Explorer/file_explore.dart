import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/utils/Rightclick/evaluate.dart';
import 'package:ubuntu/utils/Rightclick/show_on_rightclick_menu.dart';

import '../../System_Apps/File_Explorer/file_icon.dart';
import '../../controllers/file_controller.dart';
import '../../models/app.dart';
import '../../models/file.dart';

import '../../constants.dart';

class FileExplorer extends StatefulWidget {
  final App app;
  final Map? params;

  const FileExplorer({Key? key, required this.app, this.params})
      : super(key: key);

  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  String? dir;
  @override
  void initState() {
    super.initState();
    dir = widget.params!["dir"];
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.deferToChild,
        onPointerDown: (event) {
          onPointerDown(context, event);
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            toolbarHeight: 30.0 + defaultPadding,
            elevation: 0,
            leadingWidth: 30.0 + defaultPadding,
            centerTitle: true,
            title: Text(dir!, style: Theme.of(context).textTheme.subtitle1),
            leading: Padding(
              padding: const EdgeInsets.only(
                  left: defaultPadding, top: defaultPadding),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor)),
                  onPressed: _onBackPressed,
                  child: Icon(Icons.arrow_back_ios)),
            ),
          ),
          body: GetBuilder<FileController>(
              autoRemove: false,
              id: "explorer",
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Wrap(
                    runSpacing: 20.0,
                    spacing: 30.0,
                    children: [
                      for (MyFile file in controller.getFiles(dir))
                        FileIcon(
                          file: file,
                          onOpened: _onOpened,
                          openDirInNewWindow: false,
                        )
                    ],
                  ),
                );
              }),
        ));
  }

  void _onOpened(MyFile file) {
    if (file.file is Directory)
      setState(() {
        dir = file.file!.path;
      });
  }

  void _onBackPressed() {
    final split = dir!.split("/");
    print("Greater than ${split.length}");
    if (split.length > 2) {
      setState(() {
        split.removeLast();
        dir = split.join("/");
      });
    }
  }

  Future<void> onPointerDown(context, PointerDownEvent event) async {
    await MouseRightClick(options: [
      MenuOptions.newFolder,
      MenuOptions.newFile,
      MenuOptions.openTerminal,
    ]).showOnRightClickMenu(context, event, Evaluate(currentPath: dir!));
  }
}
