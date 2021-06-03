import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../screens/Desktop/components/status_menu.dart';
import '../../../utils/real_time_date.dart';

import '../../../constants.dart';

taskManger(BuildContext context, Function(OverlayEntry entry) onPressed) {
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

    //date
    title: StreamBuilder<DateTime>(
        stream: dateStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Text(
              DateFormat('E MMM d H : mm a').format(DateTime.now()),
              style: Theme.of(context).textTheme.headline4,
            );
          else
            return Offstage();
        }),
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
  OverlayEntry? entry;
  entry = OverlayEntry(builder: (context) {
    return Positioned(
        right: 20,
        top: topAppBarHeight + 5,
        child: StatusMenu(
          entry: entry,
        ));
  });
  return entry;
}
