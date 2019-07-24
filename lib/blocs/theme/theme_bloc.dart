import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

class ThemeBloc extends BaseBloc {
  StreamController<Map<String, dynamic>> _themeController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get themeControllerStream =>
      _themeController.stream;
  StreamSink<Map<String, dynamic>> get themeControllerSink =>
      _themeController.sink;

  // EVENTS

  StreamController<int> _changeThemeEventController = StreamController<int>();
  Stream<int> get changeThemeEventStream => _changeThemeEventController.stream;
  StreamSink<int> get changeThemeEventSink => _changeThemeEventController.sink;

  ThemeBloc() {
    changeThemeEventStream.listen((data) {
      _setTheme(data);
    });
  }

  void _setTheme(int index) {
    Map<String, dynamic> map = {};
    switch (index) {
      case 0:
        map["name"] = "Black";
        map["primaryColor"] = Color(0XFF000000);
        map["accentColor"] = Color(0XFFBDBDBD);
        break;
      case 1:
        map["name"] = "Pink";
        map["primaryColor"] = Color(0XFFE91E63);
        map["accentColor"] = Color(0XFFF48FB1);
        break;
      case 2:
        map["name"] = "Purple";
        map["primaryColor"] = Color(0XFF9C27B0);
        map["accentColor"] = Color(0XFFCE93D8);
        break;
      case 3:
        map["name"] = "Blue";
        map["primaryColor"] = Color(0XFF2196F3);
        map["accentColor"] = Color(0XFF90CAF9);
        break;
      default:
        map["name"] = "Black";
        map["primaryColor"] = Color(0XFF000000);
        map["accentColor"] = Color(0XFFBDBDBD);
    }
    themeControllerSink.add(map);
  }

  @override
  void dispose() {
    _themeController.close();
    _changeThemeEventController.close();
  }
}

ThemeBloc themeBloc = ThemeBloc();
