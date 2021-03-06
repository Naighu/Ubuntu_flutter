import 'dart:ui';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import '../../utils/real_time_date.dart';

class LockScreen extends StatelessWidget {
  final String wallpaper;

  const LockScreen({Key? key, required this.wallpaper}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white);
    print("LoKsCern");
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset(
                  "assets/wallpapers/$wallpaper",
                ).image,
                fit: BoxFit.cover)),
        child: Focus(
            autofocus: true,
            onKey: (_, __) {
              Navigator.pop(context);
              return true;
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 20),
              child: Center(
                  child: StreamBuilder<DateTime>(
                      stream: dateStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: DateFormat('H : mm a\n\n')
                                          .format(snapshot.data!),
                                      style: style),
                                  TextSpan(
                                      text: DateFormat('E MMM d\n\n\n\n')
                                          .format(snapshot.data!),
                                      style: style.copyWith(fontSize: 20)),
                                  TextSpan(
                                      text: "Click any key to continue",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey))
                                ],
                              ));
                        else
                          return Offstage();
                      })),
            )),
      ),
    );
  }
}
