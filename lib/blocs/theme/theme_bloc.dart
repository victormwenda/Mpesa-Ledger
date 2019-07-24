import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/models/shared_preferences_model.dart';

class ThemeBloc extends BaseBloc {
  StreamController<Map<String, dynamic>> _themeController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get themeControllerStream =>
      _themeController.stream;
  StreamSink<Map<String, dynamic>> get themeControllerSink =>
      _themeController.sink;

  // EVENTS

  StreamController<void> _getThemeEventController = StreamController<void>();
  Stream<void> get getThemeEventStream => _getThemeEventController.stream;
  StreamSink<void> get getThemeEventSink => _getThemeEventController.sink;

  StreamController<int> _changeThemeEventController = StreamController<int>();
  Stream<int> get changeThemeEventStream => _changeThemeEventController.stream;
  StreamSink<int> get changeThemeEventSink => _changeThemeEventController.sink;

  ThemeBloc() {
    sharedPreferencesBloc.getSharedPreferencesEventSink.add(null);
    sharedPreferencesBloc.sharedPreferencesStream.listen((data) {
      var themeMap = data.toMap()["themeMap"];
      if (themeMap == null) {
        _setTheme(0);
      } else {
        themeControllerSink.add(themeMap);
      }
    });

    changeThemeEventStream.listen((data) {
      _setTheme(data);
    });
  }

  void _setTheme(int index) {
    Map<String, dynamic> map = {};
    switch (index) {
      case 0:
        map["name"] = "Black";
        map["primaryColor"] = 0XFF000000;
        map["accentColor"] = 0XFFBDBDBD;
        break;
      case 1:
        map["name"] = "Pink";
        map["primaryColor"] = 0XFFE91E63;
        map["accentColor"] = 0XFFF48FB1;
        break;
      case 2:
        map["name"] = "Purple";
        map["primaryColor"] = 0XFF9C27B0;
        map["accentColor"] = 0XFFCE93D8;
        break;
      case 3:
        map["name"] = "Blue";
        map["primaryColor"] = 0XFF2196F3;
        map["accentColor"] = 0XFF90CAF9;
        break;
      default:
        map["name"] = "Black";
        map["primaryColor"] = 0XFF000000;
        map["accentColor"] = 0XFFBDBDBD;
    }
    themeControllerSink.add(map);
    sharedPreferencesBloc.changeSharedPreferencesEventSink
        .add(SharedPreferencesModel.fromMap({"themeMap": map}));
  }

  @override
  void dispose() {
    _themeController.close();
    _changeThemeEventController.close();
    _getThemeEventController.close();
  }
}

ThemeBloc themeBloc = ThemeBloc();
