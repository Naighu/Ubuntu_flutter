import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';

import 'screens/Desktop/desktop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ubuntu LTS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color.fromRGBO(221, 72, 20, 1),
            tooltipTheme: TooltipThemeData(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  border: Border.all(color: Color(0xFF222222), width: 3.0)),
              textStyle: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            iconTheme:
                IconThemeData(color: Colors.white.withOpacity(0.7), size: 20),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(0.3))),
            ),
            textTheme: TextTheme(
                headline4: TextStyle(fontSize: 14, color: Colors.white))),
        home: Desktop());
  }
}
