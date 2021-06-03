import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/system_controller.dart';

import 'evaluate.dart';

enum MenuOptions {
  newFolder,
  newFile,
  openTerminal,
  settings,
  delete,
  open,
  copy,
  paste
}
Map<MenuOptions, String> menuName = {
  MenuOptions.newFolder: "New Folder",
  MenuOptions.newFile: 'New File',
  MenuOptions.openTerminal: 'Open in Terminal',
  MenuOptions.settings: 'Settings',
  MenuOptions.delete: "Delete",
  MenuOptions.open: "open",
  MenuOptions.copy: "copy",
  MenuOptions.paste: "paste",
};

Map<MenuOptions, int> menuValue = {
  MenuOptions.newFolder: 1,
  MenuOptions.newFile: 2,
  MenuOptions.openTerminal: 3,
  MenuOptions.settings: 4,
  MenuOptions.delete: 5,
  MenuOptions.open: 6,
  MenuOptions.copy: 7,
  MenuOptions.paste: 8,
};

class MouseClick {
  Rect? rect;
  RenderBox? _renderBox;
  final List<MenuOptions> options;

  /// check whether the overlay is already present on the screeen
  static bool isActive = false;

  MouseClick({required this.options, this.rect});

  bool _onRightClick(context, PointerDownEvent event) {
    // Check if right mouse button clicked
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      _renderBox = Overlay.of(context)!.context.findRenderObject() as RenderBox;
      if (rect == null) rect = event.position & Size(48, 48.0);
      return true;
    }
    return false;
  }

  Future showOnRightClickMenu(context, event, Evaluate evaluate) async {
    if (_onRightClick(context, event)) {
      if (!isActive) {
        isActive = true;
        final menuItem = await _createWidget(context);

        evaluate.evaluate(context, menuItem);
        isActive = false;
      }
    }
  }

  Future _createWidget(context) => showMenu(
      context: context,
      color: Theme.of(context).backgroundColor,
      items: [
        for (MenuOptions option in options)
          PopupMenuItem(
              child: Text(menuName[option]!, style: _getStyle(context, option)),
              value: menuValue[option]),
      ],
      position: RelativeRect.fromSize(rect!, _renderBox!.size));

  TextStyle _getStyle(context, MenuOptions option) {
    TextStyle style;
    if (option == MenuOptions.paste) {
      if (Get.find<SystemController>().clipboard != null)
        style = Theme.of(context).textTheme.subtitle1!;
      else
        style = Theme.of(context).textTheme.subtitle2!;
    } else
      style = Theme.of(context).textTheme.subtitle1!;
    return style;
  }
}
