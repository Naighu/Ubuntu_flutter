import 'package:flutter/material.dart';

import '../models/app.dart';

class AppController extends ChangeNotifier {
  final List<App> _appStack = [];

  List<App> get appStack => _appStack;

  void addApp(App app) {
    _appStack.add(app);
    notifyListeners();
  }

  void removeApp(App app) {
    _appStack.remove(app);
    notifyListeners();
  }
}
