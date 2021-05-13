import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu/constants.dart';

import 'Apps/terminal/controllers/terminal_controller.dart';
import 'controllers/app_controller.dart';
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
      home: ChangeNotifierProvider(
        create: (context) => AppController(),
        child: Desktop(),
      ),
    );
  }
}
