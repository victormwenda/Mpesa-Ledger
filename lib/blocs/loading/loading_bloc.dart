import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

class LoadingBloc extends BaseBloc {

  StreamController<bool> _loadingController = StreamController<bool>.broadcast();
  Stream<bool> get loadingStream => _loadingController.stream;
  StreamSink<bool> get loadingSink => _loadingController.sink;

  @override
  void dispose() {
    _loadingController.close();
  }
  
}