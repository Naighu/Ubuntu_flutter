import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';

import 'package:ubuntu/Apps/terminal/commands/shell.dart';

class Gedit extends StatefulWidget {
  final String path;
  const Gedit({Key key, this.path}) : super(key: key);

  @override
  _GeditState createState() => _GeditState();
}

class _GeditState extends State<Gedit> {
  TextEditingController controller;
  bool a = false;
  @override
  void initState() {
    super.initState();
    String text = "";
    if (widget.path != null) text = Cat().cat(widget.path);
    controller = TextEditingController(text: text);
  }

  @override
  void dispose() {
    print("Disposing");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      shadowColor: null,
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Shell shell = Shell.init();
                    print(controller.text);
                    shell.updateFile(widget.path, controller.text);
                  },
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
            ),
            TextField(
              autofocus: true,
              decoration: null,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: controller,
            ),
          ],
        ));
  }
}
