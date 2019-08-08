import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/main_calculator.dart';
import 'package:mpesa_ledger_flutter/screens/category/main_category.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/main_home.dart';
import 'package:mpesa_ledger_flutter/screens/summary/main_summary.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class BottombarNavigationBloc extends BaseBloc {
  StreamController<Widget> _screensController = StreamController<Widget>();
  Stream<Widget> get screensControllerStream => _screensController.stream;
  StreamSink<Widget> get screensControllerSink => _screensController.sink;

  // EVENTS

  StreamController<Screens> _changeScreenEventController =
      StreamController<Screens>();
  Stream<Screens> get changeScreenEventStream =>
      _changeScreenEventController.stream;
  StreamSink<Screens> get changeScreenEventSink =>
      _changeScreenEventController.sink;

  StreamController<int> _selectIndexEventController =
      StreamController<int>();
  Stream<int> get selectIndexEventStream =>
      _selectIndexEventController.stream;
  StreamSink<int> get selectIndexEventSink =>
      _selectIndexEventController.sink;

  BottombarNavigationBloc() {
    changeScreenEventStream.listen((data) {
      _showScreen(data);
    });
  }

  void _showScreen(Screens screen) {
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

  @override
  void dispose() {
    _screensController.close();
    _changeScreenEventController.close();
    _selectIndexEventController.close();
  }
}
