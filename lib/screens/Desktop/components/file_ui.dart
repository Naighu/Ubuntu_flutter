import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/gedit/gedit.dart';
import 'package:ubuntu/controllers/app_controller.dart';
import 'package:ubuntu/controllers/file_controller.dart';
import 'package:ubuntu/models/app.dart';
import 'package:ubuntu/models/file.dart';

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
      left: menuWidth + widget.file.offset.dx,
      top: widget.file.offset.dy,
      child: Container(
        color: _hoverColor,
        height: 80.0,
        width: 80.0,
        child: InkWell(
          mouseCursor: MouseCursor.uncontrolled,
          onHover: (hover) {
            setState(() {
              if (hover)
                _hoverColor = Colors.red;
              else
                _hoverColor = Colors.transparent;
            });
          },
          onDoubleTap: () {
            if (widget.file.file is File) {
              final controller = Get.find<AppController>();
              controller.appStack.add(App(
                  icon: null,
                  name: widget.file.fileName,
                  offset: Offset.zero,
                  child: Gedit(
                    path: widget.file.file.path,
                  )));
            }
          },
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              startDragOffset = details.globalPosition;
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
    );
  }

  void _dragUpdate(DragUpdateDetails details, Size size) {
    final newOffset =
        widget.file.offset + (details.globalPosition - startDragOffset);
    // boundary conditions to drag
    if (newOffset.dx < size.width &&
        newOffset.dy + topAppBarHeight < size.height &&
        newOffset.dy > 0)
      widget.controller.changeOffset(widget.file, newOffset);

    startDragOffset = details.globalPosition;
  }
}
