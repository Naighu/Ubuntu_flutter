import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/controllers/menu_controller.dart';

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
  bool isClosed = false;
  bool isMaximized = false;
  final MenuController _menuController = Get.find<MenuController>();
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
          left: widget.app.offset.dx,
          top: widget.app.offset.dy,
          child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceOut,
              opacity: isClosed ? 0 : 1,
              onEnd: () {
                controller.appStack.remove(widget.app);
                widget.app.offset = Offset.zero;
                widget.app.width = 600;
                widget.app.height = 600;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
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
                      child: titleBar(context, widget.app, theme, onClose: () {
                        Get.find<MenuController>().menubarWidth.value =
                            menuWidth;
                        setState(() {
                          isClosed = true;
                        });
                      }, onMaximized: () {})),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: widget.app.height - topAppBarHeight,
                      width: widget.app.width,
                      child: widget.app.child)
                ]),
              )),
        );
    });
  }

  void _dragUpdate(DragUpdateDetails details, _appController, Size size) {
    final newOffset =
        widget.app.offset + (details.globalPosition - startDragOffset);
    // boundary conditions to drag
    if (newOffset.dx + widget.app.width < size.width &&
        newOffset.dy + widget.app.height < size.height &&
        newOffset.dy > 0 &&
        newOffset.dx > 0) _appController.changeOffset(widget.app, newOffset);

    if (newOffset.dx > 0 && newOffset.dx < 10) {
      print("menubar hide");

      _menuController.menubarWidth.value = 0;
    } else if (newOffset.dx > 30)
      _menuController.menubarWidth.value = menuWidth;
    startDragOffset = details.globalPosition;
  }
}
