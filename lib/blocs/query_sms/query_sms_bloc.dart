import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/models/shared_preferences_model.dart';
import 'package:mpesa_ledger_flutter/services/sms_filter/index.dart';
import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class QuerySMSBloc extends BaseBloc {
  var methodChannel = MethodChannelClass();
  SMSFilter smsFilter = SMSFilter();

  StreamController<void> _retrieveSMSController = StreamController<void>();
  Stream<void> get retrieveSMSStream => _retrieveSMSController.stream;
  StreamSink<void> get retrieveSMSSink => _retrieveSMSController.sink;

  StreamController<bool> _retrieveSMSCompleteController =
      StreamController<bool>.broadcast();
  Stream<bool> get retrieveSMSCompleteStream =>
      _retrieveSMSCompleteController.stream;
  StreamSink<bool> get retrieveSMSCompleteSink =>
      _retrieveSMSCompleteController.sink;

  Future<List<dynamic>> _retrieveSMSMessages() async {
    var result = await methodChannel.invokeMethod("retrieveSMSMessages");
    return result;
  }

  QuerySMSBloc() {
    retrieveSMSStream.listen((void data) async {
      await smsFilter.addSMSTodatabase(await _retrieveSMSMessages());
      sharedPreferencesBloc.changeSharedPreferencesEventSink
          .add(SharedPreferencesModel.fromMap({"isDBCreated": true}));
      retrieveSMSCompleteSink.add(true);
    });
  }

  @override
  void dispose() {
    _retrieveSMSController.close();
    _retrieveSMSCompleteController.close();
  }
}

class QuerySMSCounterPercentage extends BaseBloc {
  StreamController<int> _percentageProcessController = StreamController<int>.broadcast();
  Stream<int> get percentageProcessStream =>
      _percentageProcessController.stream;
  StreamSink<int> get percentageProcessSink =>
      _percentageProcessController.sink;

  @override
  void dispose() {
    _percentageProcessController.close();
  }
}

QuerySMSCounterPercentage counterPercentage = QuerySMSCounterPercentage();
