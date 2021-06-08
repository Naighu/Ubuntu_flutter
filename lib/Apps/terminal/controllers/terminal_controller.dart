import 'package:get/get.dart';
import 'package:ubuntu/models/app.dart';

import '../../../constants.dart';

///Controller for terminal screen.

class TerminalController extends GetxController {
  late List blocks;
  late App app;
  late List<TerminalOutput> outputs;
  String? _prevHeader;

  ///Present working path
  String? path;

  /// inorder to work clear command.. used as key for listView
  int cleared = 0;
  TerminalController({
    String header = "",
    String currentPath = rootDir,
    required this.app,
  }) {
    _prevHeader = "";
    blocks = [];
    blocks.add(Header(
        id: 0, //initial id as 0
        header: header));
    outputs = [];
    path = currentPath;
  }

  /// Output result is added to the terminal...
  ///  if the [end] is true the command execution finished.

  void addOutputString(int id, String? text,
      {bool end = true, String header = ""}) {
    TerminalOutput terminalOutput;
    if (id > outputs.length - 1) {
      terminalOutput = TerminalOutput(id);
      blocks.add(terminalOutput);
      terminalOutput.outputs.add(text);
      outputs.add(terminalOutput);
    } else {
      terminalOutput = outputs[id];

      terminalOutput.outputs.add(text);
      outputs[id] = terminalOutput;
    }

    if (end) {
      blocks.add(
          Header(id: id + 1, header: header.isEmpty ? _prevHeader! : header));
      _prevHeader = header.isEmpty ? _prevHeader : header;
    }
    print("ADDED");
    update();
  }

  /// removes all the blocks..
  void removeAll(String tag) {
    cleared += 1;
    blocks.clear();
    outputs.clear();
    blocks.add(Header(id: 0, header: _prevHeader!));
    update();
  }
}

///Here the process execution results will be stored...
///[id] is unique.Use this is to append the results in the [outputs] list.
class TerminalOutput {
  final int id;
  late List<String?> outputs;
  TerminalOutput(this.id) {
    outputs = [];
  }
}

class Header {
  final int id;
  final String header;

  Header({required this.id, required this.header});
}
