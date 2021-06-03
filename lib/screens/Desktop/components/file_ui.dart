import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../models/file.dart';
import '../../../System_Apps/File_Explorer/file_icon.dart';
import '../../../constants.dart';

class FileUi extends StatelessWidget {
  final List<MyFile> files;

  const FileUi({Key? key, required this.files}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: menuWidth, top: 20, right: 20),
      child: Container(
        height: MediaQuery.of(context).size.height - topAppBarHeight - 20,
        width: MediaQuery.of(context).size.width - menuWidth - 20,
        child: Wrap(
          direction: Axis.vertical,
          runAlignment: WrapAlignment.end,
          runSpacing: defaultPadding * 2,
          spacing: defaultPadding * 2,
          children: [
            for (MyFile file in files)
              FileIcon(
                file: file,
                openDirInNewWindow: true,
              )
          ],
        ),
      ),
    );
  }
}
