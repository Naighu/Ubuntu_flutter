import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubuntu/Apps/terminal/components/terminal_block.dart';

class TerminalController extends GetxController {
  final List<TerminalBlock> _blocks = [
    TerminalBlock(
      id: 0,
    )
  ];
  final List<String> headers = [""];
  final List<String> outputs = [""];
  String listKey = "key";
  final Size windowSize;
  TerminalController(this.windowSize);
  String path = "/naighu";
  List<TerminalBlock> get blocks => _blocks;

  void add(int id) {
    _blocks.add(TerminalBlock(
      id: _blocks.length,
    ));
    print("Bolck added");
    if (headers.length - 1 == id) headers.add(headers[id]);
    outputs.add("");

    print("Updaying");
    update();
  }

  void removeAll() {
    _blocks.clear();
    headers.clear();
    outputs.clear();
    headers.add("");
    outputs.add("");
    listKey = "chnged";
    update();
  }
}
