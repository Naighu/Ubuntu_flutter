import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../controllers/file_controller.dart';
import '../../../models/file.dart';
import '../../../System_Apps/File_Explorer/file_icon.dart';
import '../../../constants.dart';

class FileUi extends StatefulWidget {
  final MyFile file;
  final FileController controller;
  const FileUi({Key? key, required this.file, required this.controller})
      : super(key: key);

  @override
  FileUiState createState() => FileUiState();
}

class FileUiState extends State<FileUi> {
  late Offset startDragOffset;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.file.offset.dx,
      top: widget.file.offset.dy,
      child: GestureDetector(
          onPanStart: (DragStartDetails details) {
            startDragOffset = details.globalPosition;
          },
          onPanUpdate: (DragUpdateDetails details) {
            _dragUpdate(details, MediaQuery.of(context).size);
          },
          child: FileIcon(
            file: widget.file,
            openDirInNewWindow: true,
          )),
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
}
