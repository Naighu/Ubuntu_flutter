import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/gedit/gedit.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:ubuntu/models/file.dart';
import 'package:ubuntu/utils/show_on_rightclick_menu.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';
import '../../../constants.dart';

class FileUi extends StatefulWidget {
  final MyFile file;
  final FileController controller;
  const FileUi({Key key, @required this.file, @required this.controller})
      : super(key: key);

  @override
  _FileUiState createState() => _FileUiState();
}

class _FileUiState extends State<FileUi> {
  Offset startDragOffset;
  Color _hoverColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.file.offset.dx,
      top: widget.file.offset.dy,
      child: Container(
        color: _hoverColor,
        height: 80.0,
        width: 80.0,
        child: Listener(
          onPointerDown: (event) {
            _onPointerDown(context, event);
          },
          child: MouseRegion(
            onHover: (PointerHoverEvent event) {
              setState(() {
                _hoverColor = Colors.red;
              });
            },
            onExit: (PointerExitEvent event) {
              setState(() {
                _hoverColor = Colors.transparent;
              });
            },
            child: GestureDetector(
              onDoubleTap: () {
                if (widget.file.file is File) {
                  final controller = Get.find<AppController>();
                  controller.appStack.add(App(
                      icon: "assets/app_icons/gedit.png",
                      name: widget.file.fileName,
                      context: context,
                      packageName: "gedit",
                      child: Gedit(
                        path: widget.file.file.path,
                      )));
                }
              },
              onPanStart: (DragStartDetails details) {
                startDragOffset = details.globalPosition;
                _hoverColor = Colors.transparent;
              },
              onPanUpdate: (DragUpdateDetails details) {
                _dragUpdate(details, MediaQuery.of(context).size);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.file.icon,
                  Text(
                    widget.file.fileName,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dragUpdate(DragUpdateDetails details, Size size) {
    final newOffset =
        widget.file.offset + (details.globalPosition - startDragOffset);
    // boundary conditions to drag
    if (newOffset.dx < size.width &&
        newOffset.dy + topAppBarHeight < size.height &&
        newOffset.dx > menuWidth &&
        newOffset.dy > 0)
      this.setState(() {
        widget.file.setOffset = newOffset;
      });

    startDragOffset = details.globalPosition;
  }

  Future<void> _onPointerDown(context, PointerDownEvent event) async {
    print("File ui Right");
    // Check if right mouse button clicked
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      final overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      await MouseRightClick(
          Rect.fromLTWH(
              widget.file.offset.dx - 80, widget.file.offset.dy + 80, 100, 100),
          overlay.size,
          [
            MenuOptions.open,
            MenuOptions.delete,
            MenuOptions.settings,
          ]).showOnRightClickMenu(context, onPressed: (option) {
        if (option == MenuOptions.delete) {
          if (widget.file.file is File)
            Rm().rm(widget.controller, rootDir, widget.file.fileName);
          else {
            print("folder removed");
            Rmdir().rmdir(widget.controller, rootDir, widget.file.fileName);
          }
        } else if (option == MenuOptions.open && widget.file.file is File) {
          final controller = Get.find<AppController>();
          controller.appStack.add(App(
              icon: "assets/app_icons/gedit.png",
              name: widget.file.fileName,
              context: context,
              packageName: "gedit",
              child: Gedit(
                path: widget.file.file.path,
              )));
        }
      });
    }
  }
}
