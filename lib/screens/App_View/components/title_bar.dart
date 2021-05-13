import 'package:flutter/material.dart';

import '../../../models/app.dart';
import '../../../constants.dart';

PreferredSizeWidget titleBar(App app, ThemeData theme) => AppBar(
      backgroundColor: Color(0xFF161616),
      toolbarHeight: topAppBarHeight,
      centerTitle: true,
      title: Text(
        app.name,
        style: theme.textTheme.headline4,
      ),
      actions: [
        InkWell(
            onTap: () {
              print("Minimize");
            },
            child:
                Icon(Icons.minimize, size: 16, color: theme.iconTheme.color)),
        const SizedBox(width: defaultPadding),
        InkWell(
            onTap: () {
              print("maximize");
            },
            child: Icon(Icons.crop_square,
                size: 16, color: theme.iconTheme.color)),
        const SizedBox(width: defaultPadding),
        Container(
          margin: const EdgeInsets.only(right: defaultPadding),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: InkWell(
              onTap: () {
                print("close");
              },
              child: Icon(Icons.close, size: 16, color: theme.iconTheme.color)),
        )
      ],
    );
