import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ubuntu/controllers/app_controller.dart';

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
  // final AppController _appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print("AppView rebuilding");
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<AppController>(builder: (controller) {
      if (!widget.app.showOnScreen)
        return Container();
      else
        return Positioned(
            left: menuWidth + widget.app.offset.dx,
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
                      _dragUpdate(details, controller, size);
                    },
                    child: titleBar(context, widget.app, theme)),
                SizedBox(
                    height: widget.app.height - topAppBarHeight,
                    width: widget.app.width,
                    child: widget.app.child)
              ]),
            ));
    });
  }

  void _dragUpdate(DragUpdateDetails details, _appController, Size size) {
    final newOffset =
        widget.app.offset + (details.globalPosition - startDragOffset);
    // boundary conditions to drag
    if (newOffset.dx + widget.app.width * 0.5 < size.width &&
        newOffset.dy + topAppBarHeight < size.height &&
        newOffset.dy > 0) _appController.changeOffset(widget.app, newOffset);

    startDragOffset = details.globalPosition;
  }
}
