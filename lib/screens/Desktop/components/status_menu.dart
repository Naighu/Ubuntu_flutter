import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ubuntu/screens/Desktop/components/status_menu_items.dart';

import '../../../constants.dart';

class StatusMenu extends StatefulWidget {
  @override
  _StatusMenuState createState() => _StatusMenuState();
}

class _StatusMenuState extends State<StatusMenu> {
  double _currentVol = 0, _currentBrightness = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 250,
        height: 320,
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _slider(
              "assets/status/audio-headphones-symbolic.svg",
              Slider(
                value: _currentVol,
                activeColor: Colors.white70,
                inactiveColor: Colors.white24,
                min: 0,
                max: 100,
                divisions: 5,
                label: _currentVol.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentVol = value;
                  });
                },
              ),
            ),
            _slider(
              "assets/status/display-brightness-symbolic.svg",
              Slider(
                value: _currentBrightness,
                activeColor: Colors.white70,
                inactiveColor: Colors.white24,
                min: 0,
                max: 100,
                divisions: 5,
                label: _currentVol.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentBrightness = value;
                  });
                },
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 50.0,
              endIndent: 50.0,
            ),
            StatusMenuItems(
                title: "Wifi Name",
                image:
                    "assets/status/network-wireless-signal-good-symbolic.svg",
                textDim: true),
            StatusMenuItems(
                title: "Off",
                image: "assets/status/bluetooth-symbolic.svg",
                textDim: true),
            StatusMenuItems(
                title: "Battery Health (50%)",
                image: "assets/status/battery-good-symbolic.svg",
                textDim: true),
            const Divider(
              color: Colors.black,
              indent: 50.0,
              endIndent: 50.0,
            ),
            StatusMenuItems(
                title: "Settings",
                image: "assets/status/emblem-system-symbolic.svg",
                trailingIcon: true),
            StatusMenuItems(
                title: "Lock Screen",
                image: "assets/status/changes-prevent-symbolic.svg",
                trailingIcon: true),
            StatusMenuItems(
                title: "Power Off",
                image: "assets/status/system-shutdown-symbolic.svg",
                trailingIcon: true),
          ],
        ),
      ),
    );
  }

  _slider(String imagePath, Slider child) => Padding(
        padding: const EdgeInsets.only(left: defaultPadding),
        child: Row(
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(width: defaultPadding),
            SizedBox(
              height: 20.0,
              width: 200,
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 2.0,
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
                  ),
                  child: child),
            )
          ],
        ),
      );
}