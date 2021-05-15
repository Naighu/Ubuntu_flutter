import 'package:flutter/material.dart';
import 'package:ubuntu/controllers/file_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: menuWidth + widget.file.offset.dx,
      top: widget.file.offset.dy,
      child: SizedBox(
        height: 100.0,
        width: 70.0,
        child: GestureDetector(
          onPanStart: (DragStartDetails details) {
            startDragOffset = details.globalPosition;
          },
          onPanUpdate: (DragUpdateDetails details) {
            _dragUpdate(details, MediaQuery.of(context).size);
          },
          child: Column(
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
