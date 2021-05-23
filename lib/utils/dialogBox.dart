import 'package:flutter/rendering.dart';
import 'package:ubuntu/Apps/terminal/commands/bash_commands/command_packages.dart';

enum BodyType { textField }

class DialogBox {
  static OverlayEntry entry;
  String _text;
  final String title, cancelBtnName, okBtnName;
  final BodyType bodyType;
  final Function(dynamic) onOk;
  final Function() onCancel;

  DialogBox(
      {@required this.title,
      this.cancelBtnName,
      this.okBtnName,
      @required this.bodyType,
      @required this.onOk,
      this.onCancel});

  void show(context) {
    entry?.remove();
    entry = _createOverlayEntry(context);
    Overlay.of(context).insert(entry);
  }

  OverlayEntry _createOverlayEntry(context) {
    return OverlayEntry(builder: (_) {
      return LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: constraints.maxWidth * 0.5 - 200,
              top: constraints.maxHeight * 0.5 - 70,
              height: 150,
              width: 400,
              child: Material(
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(title,
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                      if (BodyType.textField == bodyType)
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: SizedBox(
                              height: 30,
                              child: TextField(
                                autofocus: true,
                                onChanged: (text) {
                                  _text = text;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 10.0, left: 10.0),
                                  border: _border(),
                                  enabledBorder: _border(),
                                  focusedBorder: _border(),
                                ),
                              ),
                            )),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder()),
                                  side: MaterialStateProperty.all(BorderSide(
                                      color: Color(0xFF161616), width: 0.5))),
                              onPressed: () {
                                entry.remove();
                                if (onCancel != null) onCancel();
                              },
                              child: Text(
                                cancelBtnName ?? "Cancel",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder()),
                                    side: MaterialStateProperty.all(BorderSide(
                                        color: Color(0xFF161616), width: 0.5))),
                                onPressed: () {
                                  entry.remove();
                                  onOk(_text);
                                },
                                child: Text(
                                  okBtnName ?? "Ok",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      });
    });
  }

  _border() => const OutlineInputBorder(
      //  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.orange));
}
