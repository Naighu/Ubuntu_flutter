import 'package:get/get.dart';
import '../../../Apps/terminal/components/header.dart';
import '../../../Apps/terminal/components/output_block.dart';

import '../../../constants.dart';

class TerminalController extends GetxController {
  RxList blocks = [].obs;
  List<TerminalOutput>? _outputs;
  List<TerminalOutput>? get outputs => _outputs;
  String? path;
  int cleared = 0; // inorder to work clear command.. used as key for listView
  TerminalController() {
    blocks.add(Header(
      id: 0,
    ));
    _outputs = [];
    path = rootDir;
  }

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

    if (end)
      blocks.add(Header(
        id: id + 1,
        header: header,
      ));
    update([id]);
  }

  void removeAll() {
    cleared += 1;
    blocks.clear();
    _outputs!.clear();
    blocks.add(Header(
      id: 0,
    ));
  }
}

class TerminalOutput {
  final int id;
  late List<String?> outputs;
  TerminalOutput(this.id) {
    outputs = [];
  }
}
