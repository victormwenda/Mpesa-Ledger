import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/index.dart';
import 'package:mpesa_ledger_flutter/screens/category/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/summary/index.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class BottombarNavigationBloc {
  StreamController<Widget> screensController = StreamController<Widget>();

  Stream<Widget> get screensControllerStream => screensController.stream;
  StreamSink<Widget> get screensControllerSink => screensController.sink;

  void showScreen(Screens screen) {
    Widget choosenScreen;
    switch (screen) {
      case Screens.home:
        choosenScreen = Home();
        break;
      case Screens.calculator:
        choosenScreen = Calculator();
        break;
      case Screens.summary:
        choosenScreen = Summary();
        break;
      case Screens.category:
        choosenScreen = Category();
        break;
      default:
        choosenScreen = Home();
    }
    screensControllerSink.add(choosenScreen);
  }

  void dispose() {
    screensController.close();
  }

}