// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WebviewFrame extends StatelessWidget {
  final String url;
  final String id;
  const WebviewFrame({Key key, @required this.url, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    ui.platformViewRegistry.registerViewFactory(
        id,
        (int viewId) => IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..onLoad);
    return Stack(
      children: [
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
        HtmlElementView(viewType: id)
      ],
    );
  }
}