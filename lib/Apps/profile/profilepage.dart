import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:ubuntu/constants.dart';
import 'package:ubuntu/models/app.dart';

class ProfilePage extends StatelessWidget {
  final App app;
  const ProfilePage({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          defaultPadding, defaultPadding, defaultPadding, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Image.asset(
                      "assets/system/logo.png",
                      height: 180,
                      width: 200,
                    ),
                  ),
                  TextSpan(
                      text: "\n\nUbuntu 21.04\n\n",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 18))
                ])),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          attributes(
                            context,
                            "Device Name",
                          ),
                          attributes(
                            context,
                            "Name",
                          ),
                          attributes(
                            context,
                            "Email Id",
                          ),
                          attributes(
                            context,
                            "Memory",
                          ),
                          attributes(context, "Processor"),
                          attributes(context, "OS Type"),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          attributesValues(
                            context,
                            "Naighu@Ubuntu",
                          ),
                          attributesValues(
                            context,
                            "Naigal Roy",
                          ),
                          attributesValues(
                            context,
                            "naighu101010@gmail.com",
                          ),
                          attributesValues(
                            context,
                            "8GB",
                          ),
                          attributesValues(context, "intel core i3"),
                          attributesValues(context, "64-bit"),
                        ],
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            _alignment(
              spacing: defaultPadding,
              children: [
                _btn(context, "assets/social_media/linked.png", "Linked In",
                    onPressed: () {
                  js.context.callMethod('open',
                      ['https://www.linkedin.com/in/naigal-roy-554217192']);
                }),
                _btn(context, "assets/social_media/github.png", "Github",
                    onPressed: () {
                  js.context.callMethod('open', ['https://github.com/Naighu']);
                }),
                _btn(context, "assets/social_media/instagram.png", "Instagram",
                    onPressed: () {
                  js.context.callMethod(
                      'open', ['https://www.instagram.com/andro_codo_hacks/']);
                }),
                _btn(context, "assets/social_media/email.png", "Email me",
                    onPressed: () {
                  js.context.callMethod('open', [
                    'mailto:naighu101010@gmail.com?Subject=About%20Ubuntu%20Flutter'
                  ]);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget attributes(context, String text) => Padding(
        padding: const EdgeInsets.only(bottom: defaultPadding),
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
  Widget attributesValues(context, String text) => Padding(
        padding: const EdgeInsets.only(bottom: defaultPadding),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );

  Widget _alignment({required List<Widget> children, double? spacing}) {
    List<Widget> _children = [];
    return LayoutBuilder(builder: (context, constraints) {
      _children.clear();
      if (app.size.width > 530) {
        for (Widget child in children) {
          _children.add(child);
          _children.add(SizedBox(
            width: spacing,
          ));
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _children,
        );
      } else {
        for (Widget child in children) {
          _children.add(child);
          _children.add(SizedBox(
            height: spacing,
          ));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _children,
        );
      }
    });
  }

  Widget _btn(context, String icon, String name, {Function()? onPressed}) =>
      TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.all(defaultPadding * 1.5)),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).accentColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ));
}
