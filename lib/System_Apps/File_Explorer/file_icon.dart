import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../Apps/terminal/commands/commands.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/file_controller.dart';
import '../../models/app.dart';
import '../../models/file.dart';
import '../../utils/show_on_rightclick_menu.dart';
import '../../utils/system_files.dart';

import '../../constants.dart';

class FileIcon extends StatefulWidget {
  final MyFile file;
  final Function(MyFile)? onOpened;
  final bool openDirInNewWindow;
  const FileIcon(
      {Key? key,
      required this.file,
      this.onOpened,
      this.openDirInNewWindow = false})
      : super(key: key);
  @override
  _FileIconState createState() => _FileIconState();
}

class _FileIconState extends State<FileIcon> {
  Color? _hoverColor;
  Map? _fileIcons;
  SystemFiles? _systemFiles;
  @override
  initState() {
    super.initState();
    _fileIcons = {};
    _hoverColor = Colors.transparent;
    if (SystemFiles.jsonData == null) {
      SystemFiles.loadJsonData().then((value) {
        setState(() {
          _systemFiles = value;
          _fileIcons = _systemFiles!.getFileIcons();
        });
      });
    } else {
      _systemFiles = SystemFiles.getObject();
      _fileIcons = _systemFiles!.getFileIcons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _onPointerDown(context, event);
      },
      child: MouseRegion(
        onHover: (PointerHoverEvent event) {
          setState(() {
            _hoverColor = Colors.red;
          });
        },
        onExit: (PointerExitEvent event) {
          setState(() {
            _hoverColor = Colors.transparent;
          });
        },
        child: Container(
          height: 80.0,
          width: 80.0,
          color: _hoverColor,
          child: InkWell(
            mouseCursor: MouseCursor.defer,
            onDoubleTap: () {
              final controller = Get.find<AppController>();
              if (widget.file.file is File) {
                App? app = controller.getAppByPackageName(_systemFiles!
                    .getAppPackageNameToOpenFile(widget.file.fileName!));
                print(app != null);
                controller.addApp(app, params: {"path": widget.file.file!.path});
              } else if (widget.openDirInNewWindow) {
                App? app = controller.getAppByPackageName("explorer");
                controller.addApp(app,
                    params: {"dir": rootDir + "/${widget.file.fileName}"});
              }
              if (widget.onOpened != null) widget.onOpened!(widget.file);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_systemFiles != null)
                  Image.asset(
                    getIcon(widget.file.fileName,
                        widget.file.file is File ? true : false)!,
                    height: 50,
                    width: 50,
                  ),
                Text(
                  widget.file.fileName!,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getIcon(String? fileName, bool isFile) {
    if (isFile) {
      String ext = fileName!.split(".").last;

      if (_fileIcons!.containsKey(ext)) return _fileIcons![ext];

      return "assets/app_icons/gedit.png";
    }
    return _systemFiles!.getDirIcon();
  }

  Future<void> _onPointerDown(context, PointerDownEvent event) async {
    final controller = Get.find<FileController>();
    // Check if right mouse button clicked
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      final overlay =
          Overlay.of(context)!.context.findRenderObject() as RenderBox;
      await MouseRightClick(
          Rect.fromLTWH(
              widget.file.offset.dx - 80, widget.file.offset.dy + 80, 100, 100),
          overlay.size,
          [
            MenuOptions.open,
            MenuOptions.delete,
            MenuOptions.settings,
          ]).showOnRightClickMenu(context, onPressed: (option) {
        if (option == MenuOptions.delete) {
          if (widget.file.file is File)
            Rm().rm(controller, rootDir, widget.file.fileName!);
          else {
            print("folder removed");
            Rmdir().rmdir(controller, rootDir, widget.file.fileName!);
          }
        } else if (option == MenuOptions.open && widget.file.file is File) {
          final controller = Get.find<AppController>();
          App? app = controller.getAppByPackageName("gedit");
          controller.addApp(app, params: {"path": widget.file.file!.path});
        }
      });
    }
  }
}
