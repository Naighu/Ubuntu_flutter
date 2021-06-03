import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';

import 'package:ubuntu/Apps/terminal/commands/shell.dart';
import 'package:ubuntu/models/app.dart';

class Gedit extends StatefulWidget {
  final App? app;
  final Map? params;
  const Gedit({Key? key, this.app, this.params}) : super(key: key);

  @override
  _GeditState createState() => _GeditState();
}

class _GeditState extends State<Gedit> {
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    String text = "";
    if (widget.params!.containsKey("path"))
      text = Cat().cat(widget.params!["path"]);
    controller = TextEditingController(text: text);
  }

  @override
  void dispose() {
    controller!.dispose();
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
                    Shell shell = Shell.init()!;
                    print(controller!.text);
                    shell.updateFile(widget.params!["path"], controller!.text);
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
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16),
              keyboardType: TextInputType.multiline,
              controller: controller,
            ),
          ],
        ));
  }
}
