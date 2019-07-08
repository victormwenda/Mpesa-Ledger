import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/main_calculator.dart';
import 'package:mpesa_ledger_flutter/screens/category/main_category.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/main_home.dart';
import 'package:mpesa_ledger_flutter/screens/summary/main_summary.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class BottombarNavigationBloc {
  StreamController<Widget> screensController = StreamController<Widget>();

  Stream<Widget> get screensControllerStream => screensController.stream;
  StreamSink<Widget> get screensControllerSink => screensController.sink;

  void showScreen(Screens screen) {
    Widget choosenScreen;
    switch (screen) {
      case Screens.home:
        choosenScreen = MainHome();
        break;
      case Screens.calculator:
        choosenScreen = MainCalculator();
        break;
      case Screens.summary:
        choosenScreen = MainSummary();
        break;
      case Screens.category:
        choosenScreen = MainCategory();
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