import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

class DropdownBloc extends BaseBloc {

  StreamController _dropdownController = StreamController();
  Stream get dropdownStream => _dropdownController.stream;
  StreamSink get dropdownSink => _dropdownController.sink;

  @override
  void dispose() {
    _dropdownController.close();
  }
  
}