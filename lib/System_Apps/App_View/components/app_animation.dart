import 'package:flutter/material.dart';

import '../../../constants.dart';

class AppAnimation extends StatelessWidget {
  final Widget Function(double height, double width, double left, double top)
      builder;
  final AnimationController controller;
  final Animation<Offset> offsetAnimation;
  final Animation<Size> sizeAnimation;
  final Size appSize;
  final Offset appOffset;
  const AppAnimation(
      {Key? key,
      required this.builder,
      required this.controller,
      required this.offsetAnimation,
      required this.sizeAnimation,
      required this.appSize,
      required this.appOffset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          //when the animation starts use the animation value
          double height = controller.status == AnimationStatus.dismissed ||
                  controller.status == AnimationStatus.completed
              ? appSize.height
              : sizeAnimation.value.height -
                  (100 *
                      (topAppBarHeight / MediaQuery.of(context).size.height));
          double width = controller.status == AnimationStatus.dismissed ||
                  controller.status == AnimationStatus.completed
              ? appSize.width
              : sizeAnimation.value.width;

          double left = controller.status ==
                      AnimationStatus
                          .dismissed || // use the animation value only when the window is rezized ..
                  controller.status == AnimationStatus.completed
              ? appOffset.dx
              : offsetAnimation.value.dx;
          double top = controller.status == AnimationStatus.dismissed ||
                  controller.status == AnimationStatus.completed
              ? appOffset.dy
              : offsetAnimation.value.dy;
          return builder(height, width, left, top);
        });
  }
}
