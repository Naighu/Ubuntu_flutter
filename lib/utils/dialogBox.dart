import 'package:flutter/rendering.dart';
import '../Apps/terminal/commands/bash_commands/command_packages.dart';

///body of the dialogbox
enum BodyType { textField }

class DialogBox {
  /// dialogbox overlay entry
  static OverlayEntry? entry;
  String? _text;

  ///[title] of the dialog

  final String? title, cancelBtnName, okBtnName;
  final BodyType bodyType;
  final Function(dynamic) onOk;
  final Function()? onCancel;

  DialogBox(
      {required this.title,
      this.cancelBtnName,
      this.okBtnName,
      required this.bodyType,
      required this.onOk,
      this.onCancel});

  ///show the dialogbox to the screen
  void show(context) {
    if (entry != null && entry!.mounted) entry?.remove();
    entry = _createOverlayEntry(context);
    Overlay.of(context)!.insert(entry!);
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
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(title!,
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                      if (BodyType.textField == bodyType) _textField(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              width: 0.5),
                                          top: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              width: 0.5))),
                                  child: Text(
                                    cancelBtnName ?? "Cancel",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                onTap: () {
                                  entry!.remove();
                                  if (onCancel != null) onCancel!();
                                },
                              )),
                          Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  entry!.remove();
                                  onOk(_text); //returns the text from textfield
                                },
                                child: Container(
                                  height: 30.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              width: 0.5))),
                                  child: Text(
                                    okBtnName ?? "Ok",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
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

  Widget _textField() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 30,
        child: TextField(
          autofocus: true,
          onChanged: (text) {
            _text = text;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(),
          ),
        ),
      ));
}
