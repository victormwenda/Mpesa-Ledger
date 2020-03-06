import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

class WalkThroughBloc extends BaseBloc {

  StreamController<Map<String, dynamic>> _walkThroughController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get walkThroughControllerStream =>
      _walkThroughController.stream;
  StreamSink<Map<String, dynamic>> get walkThroughControllerSink =>
      _walkThroughController.sink;

  // EVENTS

  StreamController<int> _changePageEventController = StreamController<int>();
  Stream<int> get changePageEventStream => _changePageEventController.stream;
  StreamSink<int> get changePageEventSink => _changePageEventController.sink;


  @override
  void dispose() {
    
  }
  
}