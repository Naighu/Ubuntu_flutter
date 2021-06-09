import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ubuntu/Apps/terminal/commands/commands.dart';

import 'package:ubuntu/Apps/terminal/commands/shell.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/models/app.dart';

class Gedit extends StatefulWidget {
  final App? app;
  final Map? params;
  const Gedit({Key? key, this.app, this.params}) : super(key: key);

  @override
  _GeditState createState() => _GeditState();
}

class _GeditState extends State<Gedit> {
  late TextEditingController controller;
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.only(right: defaultPadding),
              height: 50,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  WebShell shell = WebShell.init()!;
                  print(controller.text);
                  shell.updateFile(widget.params!["path"], controller.text);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 60.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(color: Theme.of(context).accentColor),
                      child: Text(
                        "Save",
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ListView(
                children: [
                  TextField(
                    autofocus: true,
                    decoration: null,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16),
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
