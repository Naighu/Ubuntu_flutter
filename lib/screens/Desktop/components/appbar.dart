import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

desktopAppBar(ThemeData theme) => AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: topAppBarHeight,
      leadingWidth: 80.0,
      leading: Center(
        child: Text(
          "Activites",
          style: theme.textTheme.headline4,
        ),
      ),
      centerTitle: true,
      title: Text(
        DateFormat('E MMM d H : m a').format(DateTime.now()),
        style: theme.textTheme.headline4,
      ),
      actions: [
        Icon(Icons.wifi),
        const SizedBox(width: defaultPadding),
        Icon(Icons.volume_down),
        const SizedBox(width: defaultPadding),
        Icon(Icons.battery_full),
        Icon(Icons.arrow_drop_down),
      ],
    );
