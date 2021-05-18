import 'package:flutter/material.dart';
import 'package:ubuntu/models/file.dart';

class FileIcon extends StatefulWidget {
  final MyFile file;

  const FileIcon({Key key, this.file}) : super(key: key);
  @override
  _FileIconState createState() => _FileIconState();
}

class _FileIconState extends State<FileIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.file.icon,
        Text(
          widget.file.fileName,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
