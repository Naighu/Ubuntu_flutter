import 'package:get/get.dart';
import 'package:ubuntu/controllers/file_controller.dart';

import 'command_packages.dart';

class Mkdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String fileName) {
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    String message = mkdir(fileController, controller.path, fileName);
    controller.addOutputString(id!, message);
  }

  String mkdir(FileController fileController, String? path, String fileName) {
    List items = Ls().ls(path);
    String error = "";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items) {
        List split = item.path.split("/");
        split.removeLast();

        if (item is Directory &&
            item.path.trim() == split.join("/") + "/$fileName") {
          error = "Directory Already exist";
          break;
        }
      }
    }
    if (error.isEmpty) {
      Shell shell = Shell.init()!;
      shell.create(path! + "/$fileName");
      fileController.updateUi(path + "/$fileName");
      return "";
    } else
      return error;
  }
}

class Rmdir implements DecodeCommand {
  @override
  dynamic executeCommand(BuildContext context, int? id, String command) {
    print("[Executing RMDIR]");
    final controller = Get.find<TerminalController>();
    final fileController = Get.find<FileController>();
    String path, fileName, message;
    //compiling the path
    if (command.isNotEmpty) {
      if (command.startsWith("/") || command.split("/").length >= 2) {
        var a = command.split("/");
        fileName = a.removeLast();
        path = controller.path! + "/" + a.join("/").replaceFirst("/", "");
      } else {
        var a = command.split("/");
        fileName = a.removeLast();
        path = controller.path! + a.join("/");
      }
      message = rmdir(fileController, path, fileName);
    } else
      message = "Specify a Directory name";
    print("message : $message");
    controller.addOutputString(id!, message);
  }

  rmdir(FileController fileController, String path, String fileName) {
    Ls ls = Ls();
    List items = ls.ls(path);
    String error = "Directory Not Found";

    if (fileName.isEmpty)
      error = "Specify a name";
    else {
      for (var item in items) {
        List split = item.path.split("/");
        split.removeLast();
        if (item is Directory &&
            item.path.trim() == (split.join("/") + "/$fileName").trim()) {
          error = "";
          break;
        }
      }
    }

    if (error.isEmpty) {
      var dirs = ls.ls(path +
          "/$fileName"); //checking if the selected folder is empty or not
      if (dirs.isEmpty) {
        Shell shell = Shell.init()!;
        print(path + "$fileName");
        shell.remove(path + "/$fileName");
        fileController.updateUi(path + "/$fileName");
        return "";
      } else
        error = "Directory is not empty";
    }

    return error;
  }
}
