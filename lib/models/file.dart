import 'dart:io';

import 'package:ubuntu/Apps/terminal/commands/bash_commands/command_packages.dart';

class MyFile {
  final FileSystemEntity? file;
  final String? fileName;
  MyFile({this.file, this.fileName});
}

class LinuxFile extends FileSystemEntity {
  LinuxFile(String path) {
    _path = path;
  }
  late String _path;
  @override
  FileSystemEntity get absolute => throw UnimplementedError();

  @override
  Future<bool> exists() {
    throw UnimplementedError();
  }

  @override
  bool existsSync() {
    List items = Ls().ls(path.getParentPath());
    for (var item in items)
      if (item is LinuxFile && item.path.trim() == path.trim()) return true;
    return false;
  }

  @override
  String get path => _path;

  @override
  Future<FileSystemEntity> rename(String newPath) {
    throw UnimplementedError();
  }

  @override
  FileSystemEntity renameSync(String newPath) {
    // TODO: implement renameSync
    throw UnimplementedError();
  }
}

class LinuxDirectory extends FileSystemEntity {
  LinuxDirectory(String path) {
    _path = path;
  }
  late String _path;
  @override
  FileSystemEntity get absolute => throw UnimplementedError();

  @override
  Future<bool> exists() {
    throw UnimplementedError();
  }

  @override
  bool existsSync() {
    List items = Ls().ls(path);
    for (var item in items)
      if (item is LinuxDirectory && item.path.trim() == path.trim())
        return true;
    return false;
  }

  @override
  String get path => _path;

  @override
  Future<FileSystemEntity> rename(String newPath) {
    throw UnimplementedError();
  }

  @override
  FileSystemEntity renameSync(String newPath) {
    // TODO: implement renameSync
    throw UnimplementedError();
  }
}
