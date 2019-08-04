import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

class Counter extends BaseBloc {
  StreamController<int> _counterController =
      StreamController<int>.broadcast();
  Stream<int> get counterStream =>
      _counterController.stream;
  StreamSink<int> get counterSink =>
      _counterController.sink;

  @override
  void dispose() {
    _counterController.close();
  }
}

Counter counter = Counter();