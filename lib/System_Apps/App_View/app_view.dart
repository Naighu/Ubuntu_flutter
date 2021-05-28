import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/system_controller.dart';

import '../../controllers/app_controller.dart';

import '../../constants.dart';
import '../../models/app.dart';
import 'components/title_bar.dart';

class AppView extends StatefulWidget {
  final App? app;

  const AppView({Key? key, required this.app}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with SingleTickerProviderStateMixin {
  late Offset startDragOffset;
  bool isClosed = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<Size> _sizeAnimation;
  App? get app => widget.app;
  final SystemController _menuController = Get.find<SystemController>();
  final AppController _appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    _appController.prevOffset = app!.offset;
    _appController.prevSize = app!.size;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _offsetAnimation =
        Tween<Offset>(begin: _appController.prevOffset).animate(_controller);
    _sizeAnimation =
        Tween<Size>(begin: _appController.prevSize).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    print(app!.child);
    return GetBuilder<AppController>(builder: (controller) {
      Future(() {
        _conditionToShowMenubar(); //check whether if the menubar should hide or not.
      });
      if (app!.hide)
        return Container();
      else
        return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              //when the animation starts use the animation value.This is done for making responsive..
              double height = _controller.status == AnimationStatus.dismissed ||
                      _controller.status == AnimationStatus.completed
                  ? app!.size.height
                  : _sizeAnimation.value.height -
                      (100 * (topAppBarHeight / size.height));
              double width = _controller.status == AnimationStatus.dismissed ||
                      _controller.status == AnimationStatus.completed
                  ? app!.size.width
                  : _sizeAnimation.value.width;
              return Positioned(
                left: _controller.status ==
                            AnimationStatus
                                .dismissed || // this is for having the animation when the app minimized or maximized ,not when dragging.
                        _controller.status == AnimationStatus.completed
                    ? app!.offset.dx
                    : _offsetAnimation.value.dx,
                top: _controller.status == AnimationStatus.dismissed ||
                        _controller.status == AnimationStatus.completed
                    ? app!.offset.dy
                    : _offsetAnimation.value.dy,
                child: Column(children: [
                  GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: (DragUpdateDetails details) {
                        _dragUpdate(details, size);
                      },
                      child: SizedBox(
                        height: topAppBarHeight,
                        width: width,
                        child: titleBar(context, app!, theme,
                            onClose: _onClose,
                            onScreenSizeChanged: _onScreenSizeChanged),
                      )),
                  Container(height: height, width: width, child: app!.child)
                ]),
              );
            });
    });
  }

  void _dragUpdate(DragUpdateDetails details, Size size) {
    Offset newOffset = app!.offset + (details.globalPosition - startDragOffset);
    Size appSize = app!.size;
    // boundary conditions to drag
    if (newOffset.dx + appSize.width < size.width &&
        newOffset.dy + appSize.height < size.height &&
        newOffset.dy > 0 &&
        newOffset.dx > 0) {
      setState(() {
        app!.setOffset = newOffset;
      });
    }
    startDragOffset = details.globalPosition;
  }

  void _conditionToShowMenubar() {
    //condition to show menubar
    if (app!.hide ||
        (app!.offset.dx > menuWidth + 30 &&
            _menuController.menubarWidth.value == 0))
      _menuController.menubarWidth.value = menuWidth;
    //condition to hide menubar
    else if (app!.offset.dx < menuWidth + 10 &&
        _menuController.menubarWidth.value == menuWidth)
      _menuController.menubarWidth.value = 0;
  }

  void _onScreenSizeChanged(bool isMaximized) {
    if (isMaximized)
      _controller.reverse();
    else {
      _controller.reset();
      _offsetAnimation =
          Tween<Offset>(begin: _appController.prevOffset, end: app!.offset)
              .animate(_controller);
      _sizeAnimation =
          Tween<Size>(begin: _appController.prevSize, end: app!.size)
              .animate(_controller);

      _controller.forward();
    }
  }

  void _onClose() {
    _menuController.menubarWidth.value = menuWidth;
    _appController.closeApp(app!);
  }

  void _onPanStart(DragStartDetails details) {
    if (_appController.appStack.last != app) {
      _appController.appStack.remove(app);
      _appController.appStack.add(app);
    }
    startDragOffset = details.globalPosition;
  }
}
