import 'package:flutter/material.dart';
import 'constants.dart';

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
      theme: themeData,
      home: Desktop(),
    );
  }
}
