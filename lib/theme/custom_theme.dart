import 'package:flutter/material.dart';

class CustomTheme {
  Map<String, dynamic> themeMap;
  ThemeData themeData;

  CustomTheme(this.themeMap) {
    themeData = ThemeData(
      primaryColor: themeMap["primaryColor"],
      accentColor: themeMap["accentColor"],
      cursorColor: themeMap["primaryColor"],
      focusColor: themeMap["primaryColor"],
      fontFamily: "Montserrat",
      textTheme: TextTheme(
        display3: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        headline: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
        subhead: TextStyle(
          fontSize: 15.0,
        ),
        title: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        body1: TextStyle(),
        button: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  ThemeData get getTheme => themeData;
}
