import 'package:get/get.dart';
import '../Apps/terminal/commands/bash_commands/command_packages.dart';
import '../models/file.dart';

class FileController extends GetxController {
  /// returns the files and directories of the given dir.
  List<MyFile> getFiles(String? dir) {
    List<MyFile> files = [];
    final items = Ls().ls(dir);
    for (var item in items) {
      files.add(_file(item));
    }

    return files;
  }

  ///updating the ui if new file or folder is added.
  void updateUi(String parentPath) {
    update([
      /// it will rebuild the desktopUI only when a new file or folder is created or deleted in the rootDir path
      parentPath,

      "explorer" //Always rebuild the fileExplorer app when a new file or folder is created or deleted
    ]);
  }

  ///returns the [MyFile] object from the [FileSystemEntity]
  MyFile _file(FileSystemEntity item) => MyFile(
        file: item,
        fileName: item.path.split("/").last,
      );
}
