import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ubuntu/screens/Desktop/components/status_menu.dart';

import '../../../constants.dart';

desktopAppBar(BuildContext context, Function(OverlayEntry entry) onPressed) {
  return AppBar(
    backgroundColor: Colors.black,
    toolbarHeight: topAppBarHeight,
    leadingWidth: 80.0,
    leading: Center(
      child: Text(
        "Activites",
        style: Theme.of(context).textTheme.headline4,
      ),
    ),
    centerTitle: true,
    title: Text(
      DateFormat('E MMM d H : m a').format(DateTime.now()),
      style: Theme.of(context).textTheme.headline4,
    ),
    actions: [
      InkWell(
        onTap: () {
          onPressed(onTap(context));
        },
        child: Row(
          children: [
            SvgPicture.asset(
                "assets/status/network-wireless-signal-good-symbolic.svg"),
            const SizedBox(width: defaultPadding),
            SvgPicture.asset("assets/status/audio-volume-medium-symbolic.svg"),
            const SizedBox(width: defaultPadding),
            SvgPicture.asset("assets/status/battery-good-symbolic.svg"),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    ],
  );
}

onTap(context) {
  // var value = await js.context.callMethod('getBattery');
  // print("$value");
  final entry = OverlayEntry(builder: (context) {
    return Positioned(right: 20, top: topAppBarHeight + 5, child: StatusMenu());
  });
  return entry;
}
