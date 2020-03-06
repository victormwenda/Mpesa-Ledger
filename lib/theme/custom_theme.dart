import 'package:flutter/material.dart';

class CustomTheme {
  Map<String, dynamic> themeMap;
  ThemeData themeData;

  CustomTheme(this.themeMap) {
    var primaryColor = themeMap["primaryColor"];
    var accentColor = themeMap["accentColor"];

    themeData = ThemeData(
      primaryColor: Color(primaryColor),
      accentColor: Color(accentColor),
      cursorColor: Color(primaryColor),
      focusColor: Color(primaryColor),
      fontFamily: "Quicksand",
      textTheme: TextTheme(
        display3: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        display2: TextStyle(fontSize: 55.0, color: Colors.white, fontWeight: FontWeight.bold),
        display1: TextStyle(fontSize: 35.0, color: Colors.black, fontWeight: FontWeight.bold),
        headline: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
        subhead: TextStyle(
          fontSize: 15.0,
        ),
        title: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        subtitle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        body1: TextStyle(),
        button: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  ThemeData get getTheme => themeData;
}
