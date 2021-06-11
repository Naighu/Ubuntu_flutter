// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../models/app.dart';

class WebviewFrame extends StatelessWidget {
  final App app;
  const WebviewFrame({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        app.packageName,
        (int viewId) => IFrameElement()
          ..src = app.params?["url"]
          ..style.border = 'none'
          ..onLoad);

    return Stack(
      children: [
        // Container(
        //   alignment: Alignment.center,
        //   child: CircularProgressIndicator(
        //     valueColor:
        //         AlwaysStoppedAnimation(Theme.of(context).iconTheme.color),
        //   ),
        // ),
        HtmlElementView(viewType: app.packageName),
      ],
    );
  }
}
