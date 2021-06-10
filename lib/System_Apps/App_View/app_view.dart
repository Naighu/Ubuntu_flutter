import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/System_Apps/App_View/components/app_animation.dart';
import '../../controllers/system_controller.dart';

import '../../controllers/app_controller.dart';

import '../../constants.dart';
import '../../models/app.dart';
import 'components/title_bar.dart';

class AppView extends StatefulWidget {
  final App app;

  const AppView({Key? key, required this.app}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with SingleTickerProviderStateMixin {
  late Offset startDragOffset;
  late AnimationController _controller;
  late Tween<Offset> _offsetAnimation;
  late Tween<Size> _sizeAnimation;
  final SystemController _menuController = Get.find<SystemController>();
  final AppController _appController = Get.find<AppController>();
  late TitleBar _titleBar;

  App get app => widget.app;
  @override
  void initState() {
    super.initState();

    _titleBar = TitleBar(
        app: app,
        onScreenSizeChanged: _onScreenSizeChanged,
        onClose: _onClose,
        title: app.params?["title"]);

    _appController.prevOffset = app.offset;
    _appController.prevSize = app.size;

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _offsetAnimation = Tween<Offset>(begin: _appController.prevOffset);
    _sizeAnimation = Tween<Size>(begin: _appController.prevSize);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<AppController>(builder: (controller) {
      Future(() {
        _conditionToShowMenubar(); //check whether if the menubar should hide or not.
      });

      return AppAnimation(
          controller: _controller,
          offsetAnimation: _offsetAnimation.animate(_controller),
          sizeAnimation: _sizeAnimation.animate(_controller),
          appSize: app.size,
          appOffset: app.offset,
          builder: (height, width, left, top) {
            return Positioned(
              left: left,
              top: top,
              child: Visibility(
                visible: !app.hide,
                maintainState: true,
                child: Column(children: [
                  GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: (DragUpdateDetails details) {
                        _dragUpdate(details, size);
                      },
                      child: SizedBox(
                        height: topAppBarHeight,
                        width: width,
                        child: _titleBar.titleBar(context),
                      )),
                  Container(
                      color: Theme.of(context).backgroundColor,
                      height: height,
                      width: width,
                      child: app.child)
                ]),
              ),
            );
          });
    });
  }

  void _dragUpdate(DragUpdateDetails details, Size size) {
    Offset newOffset = app.offset + (details.globalPosition - startDragOffset);
    Size appSize = app.size;
    // boundary conditions to drag
    if (newOffset.dx + appSize.width * 0.5 < size.width &&
        newOffset.dy + appSize.height * 0.5 < size.height &&
        newOffset.dy > 0 &&
        newOffset.dx > 0) {
      setState(() {
        app.setOffset = newOffset;
      });
    }
    startDragOffset = details.globalPosition;
  }

  void _conditionToShowMenubar() {
    //condition to show menubar
    // bool flag = false;
    // // if any of the apps in full screen then no need to show the menubar.
    // for (List<App> apps in _appController.appStack) {
    //   for (App a in apps)
    //     if (a.isMaximized) {
    //       flag = true;
    //       break;
    //     }
    //   if (flag) break;
    // }

    if (app.hide ||
        (app.offset.dx > menuWidth + 30 &&
            _menuController.menubarWidth.value == 0))
      _menuController.menubarWidth.value = menuWidth;
    //condition to hide menubar
    else if (app.offset.dx < menuWidth + 10 &&
        _menuController.menubarWidth.value == menuWidth)
      _menuController.menubarWidth.value = 0;
  }

  void _onScreenSizeChanged(bool isMaximized) {
    if (isMaximized)
      _controller.reverse();
    else {
      _controller.reset();

      // changing the begin and end values
      _offsetAnimation.begin = _appController.prevOffset;
      _offsetAnimation.end = app.offset;
      _sizeAnimation.begin = _appController.prevSize;
      _sizeAnimation.end = app.size;

      _controller.forward();
    }
  }

  void _onClose() {
    _menuController.menubarWidth.value = menuWidth;
    _appController.closeApp(app);
  }

  void _onPanStart(DragStartDetails details) {
    _appController.moveToFront(app);
    startDragOffset = details.globalPosition;
  }
}
