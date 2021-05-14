import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/terminal_block.dart';

class TerminalController extends GetxController {
  final List<TerminalBlock> _blocks = [TerminalBlock(header: "/naighu")];

  final Size windowSize;
  TerminalController(this.windowSize);
  String path = "/naighu";
  List<TerminalBlock> get blocks => _blocks;

  void add(TerminalBlock block) {
    _blocks.add(block);
    update();
  }

  void removeAll() {
    _blocks.clear();
    update();
  }
}
