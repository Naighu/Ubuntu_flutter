import 'package:get/get.dart';
import '../../../Apps/terminal/components/header.dart';
import '../../../Apps/terminal/components/output_block.dart';

import '../../../constants.dart';

///Controller for terminal screen.

class TerminalController extends GetxController {
  RxList blocks = [].obs;
  List<TerminalOutput>? _outputs;
  List<TerminalOutput>? get outputs => _outputs;
  String? _prevHeader;

  ///Present working path
  String? path;

  /// inorder to work clear command.. used as key for listView
  int cleared = 0;
  TerminalController() {
    _prevHeader = "";
    blocks.add(Header(
      id: 0, //initial id as 0
      header: "",
    ));
    _outputs = [];
    path = rootDir;
  }

  /// Output result is added to the terminal...
  ///  if the [end] is true the command execution finished.

  void addOutputString(int id, String? text,
      {bool end = true, String header = ""}) {
    TerminalOutput terminalOutput;

    if (id > _outputs!.length - 1) {
      blocks.add(OutputBlock(
        id: id,
      ));
      terminalOutput = TerminalOutput(id)..outputs.add(text);
      _outputs!.add(terminalOutput);
    } else {
      terminalOutput = _outputs![id];

      terminalOutput.outputs.add(text);
      _outputs![id] = terminalOutput;
    }

    if (end) {
      blocks.add(
          Header(id: id + 1, header: header.isEmpty ? _prevHeader! : header));
      _prevHeader = header.isEmpty ? _prevHeader : header;
    }
    update([id]);
  }

  /// removes all the blocks..
  void removeAll() {
    cleared += 1;
    blocks.clear();
    _outputs!.clear();
    blocks.add(Header(
      id: 0,
      header: _prevHeader!,
    ));
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
