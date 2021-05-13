import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/app.dart';
import 'components/title_bar.dart';

class AppView extends StatefulWidget {
  final App app;

  const AppView({Key key, this.app}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  Offset startDragOffset;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      left: widget.app.offset.dx,
      top: widget.app.offset.dy,
      child: Container(
          constraints: BoxConstraints(
              maxHeight: widget.app.height, maxWidth: widget.app.width),
          child: Column(children: [
            GestureDetector(
                onPanStart: (DragStartDetails details) {
                  startDragOffset = details.globalPosition;
                },
                onPanUpdate: (DragUpdateDetails details) {
                  _dragUpdate(details, size);
                },
                child: titleBar(widget.app, theme))
          ])),
    );
  }

  void _dragUpdate(DragUpdateDetails details, Size size) {
    final newOffset =
        widget.app.offset + (details.globalPosition - startDragOffset);
    print(newOffset);
    // boundary conditions to drag
    if (newOffset.dx + widget.app.width * 0.5 < size.width &&
        newOffset.dy + topAppBarHeight < size.height &&
        newOffset.dy > topAppBarHeight)
      this.setState(() {
        widget.app.offset = newOffset;
      });

    startDragOffset = details.globalPosition;
  }
}
