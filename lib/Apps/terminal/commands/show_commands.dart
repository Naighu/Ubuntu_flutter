

import 'commands.dart';

Map<String, DecodeCommand> commands = {
  "ls": Ls(),
  "cd": Cd(),
  "pwd": Pwd(),
  "mkdir": Mkdir(),
  "rmdir": Rmdir(),
  "clear": Clear(),
  "touch": Touch(),
  "cat": Cat(),
  "rm": Rm()
};
