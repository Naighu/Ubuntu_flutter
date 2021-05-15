import 'package:ubuntu/Apps/terminal/commands/commands.dart';

Map<String, DecodeCommand> commands = {
  "ls": Ls(),
  "cd": Cd(),
  "pwd": Pwd(),
  "mkdir": Mkdir(),
  "rmdir": Rmdir(),
  "mv": Mv()
};
