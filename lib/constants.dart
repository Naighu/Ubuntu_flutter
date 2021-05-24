import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const defaultPadding = 12.0, menuWidth = 60.0, topAppBarHeight = 35.0;
const rootDir = "/naighu", configFile = 'assets/config/system_config.json';
final themeData = ThemeData(
    fontFamily: GoogleFonts.ubuntuMono().fontFamily,
    primaryColor: Color.fromRGBO(56, 4, 40, 1),
    backgroundColor: Color(0xFF222222),
    accentColor: Color(0xFF161616),
    tooltipTheme: TooltipThemeData(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          border: Border.all(color: Color(0xFF222222), width: 3.0)),
      textStyle: TextStyle(fontSize: 14.0, color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white.withOpacity(0.7), size: 20),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.3))),
    ),
    textTheme: TextTheme(
        headline4: TextStyle(fontSize: 14, color: Colors.white),
        subtitle1: TextStyle(fontSize: 15, color: Colors.white70),
        bodyText2: TextStyle(
            fontSize: 14,
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold),
        bodyText1: TextStyle(fontSize: 14, color: Colors.white)));
