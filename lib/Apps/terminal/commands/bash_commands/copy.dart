import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ubuntu/controllers/file_controller.dart';

import 'command_packages.dart';

class Cp implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    String message, path1, path2, fileName1, fileName2;
    if (command.isNotEmpty) {
      path1 =
          Shell.init()!.getCorrectPath(command.split(" ")[0], controller.path!);
      if (path1.isNotEmpty) {
        List a = path1.split("/");

        fileName1 = a.removeLast();
        path1 = a.join("/");
        path2 = Shell.init()!
            .getCorrectPath(command.split(" ").last, controller.path!);
        if (path2.isNotEmpty) {
          List a = path2.split("/");

          fileName2 = a.removeLast();
          path2 = a.join("/");
          message = cp(fileController, path1, fileName1, path2, fileName2);
        } else
          message = "Incorrect path";
      } else
        message = "Incorrect path";
    } else
      message = "Specify a File name";
    controller.addOutputString(id!, message);
  }

  cp(FileController fileController, String path1, String fileName1,
      String path2, String fileName2) {
    if (kIsWeb)
      return cpWeb(fileController, path1, fileName1, path2, fileName2);
  }

  String cpWeb(FileController fileController, String path1, String fileName1,
      String path2, String fileName2) {
    List items1 = Ls().ls(path1);
    List items2 = Ls().ls(path2);

    print("[PATH 1] : $path1");
    print("[PATH 2] : $path2");
    print("File1 $fileName1");
    print("File2 $fileName2");
    String error = "File/folder not exist";
    late bool isDir;
    if (fileName1.isEmpty || fileName2.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items1) {
        if (item.path.trim() == (path1 + "/$fileName1").trim()) {
          if (item is Directory)
            isDir = true;
          else
            isDir = false;
          error = "";
          break;
        }
      }
    }

    if (isDir && items2.isNotEmpty) error = "Destination folder is not Empty";

    if (error.isEmpty) {
      Shell shell = Shell.init()!;
      shell.create(path2 + "/$fileName2", option: isDir ? "dir" : "file");
      fileController.updateUi(path2 + "/$fileName2");
      return "";
    } else
      return error;
  }
}
