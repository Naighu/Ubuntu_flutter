import 'package:flutter/material.dart';

enum MenuOptions { newFolder, newFile, openTerminal, settings, delete, open }

class MouseRightClick {
  final Rect rect;
  final Size size;
  final List<MenuOptions> options;
  static bool isActive = false;
  static Map<MenuOptions, int> menuValue = {
    MenuOptions.newFolder: 1,
    MenuOptions.newFile: 2,
    MenuOptions.openTerminal: 3,
    MenuOptions.settings: 4,
    MenuOptions.delete: 5,
    MenuOptions.open: 6,
  };
  static Map<MenuOptions, String> menuName = {
    MenuOptions.newFolder: "New Folder",
    MenuOptions.newFile: 'New File',
    MenuOptions.openTerminal: 'Open in Terminal',
    MenuOptions.settings: 'Settings',
    MenuOptions.delete: "Delete",
    MenuOptions.open: "open",
  };

  MouseRightClick(this.rect, this.size, this.options);

  Future showOnRightClickMenu(context,
      {Function(MenuOptions option)? onPressed}) async {
    if (!isActive) {
      isActive = true;
      final menuItem = await showMenu(
          context: context,
          color: Theme.of(context).backgroundColor,
          items: [
            for (MenuOptions option in options)
              PopupMenuItem(
                  child: Text(menuName[option]!, style: Theme.of(context).textTheme.subtitle1),
                  value: menuValue[option]),
          ],
          position: RelativeRect.fromSize(rect, size));
      // Check if menu item clicked
      switch (menuItem) {
        case 1:
          onPressed!(MenuOptions.newFolder);
          break;
        case 2:
          onPressed!(MenuOptions.newFile);
          break;
        case 3:
          print("Open in terminal");
          onPressed!(MenuOptions.openTerminal);
          break;
        case 4:
          onPressed!(MenuOptions.settings);
          break;
        case 5:
          onPressed!(MenuOptions.delete);
          break;
        case 6:
          onPressed!(MenuOptions.open);
          break;

        default:
      }
      isActive = false;
    }
  }
}
