import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/models/shared_preferences_model.dart';
import 'package:mpesa_ledger_flutter/sms_filter/index.dart';
import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class QuerySMSBloc extends BaseBloc {
  var methodChannel = MethodChannelClass();
  SMSFilter smsFilter = SMSFilter();

  StreamController<void> retrieveSMSController = StreamController<void>();
  Stream<void> get retrieveSMSStream => retrieveSMSController.stream;
  StreamSink<void> get retrieveSMSSink => retrieveSMSController.sink;

  StreamController<bool> retrieveSMSCompleteController = StreamController<bool>();
  Stream<bool> get retrieveSMSCompleteStream => retrieveSMSCompleteController.stream;
  StreamSink<bool> get retrieveSMSCompleteSink => retrieveSMSCompleteController.sink;

  Future<List<dynamic>> retrieveSMSMessages() async {
    var result = await methodChannel.invokeMethod("retrieveSMSMessages");
    return result;
  }

  QuerySMSBloc() {
    retrieveSMSStream.listen((void data) async {
      await smsFilter.addSMSTodatabase(await retrieveSMSMessages());
      sharedPreferencesBloc.changeSharedPreferencesSink.add(SharedPreferencesModel.fromMap({
        "isDBCreated": true
      }));
      retrieveSMSCompleteSink.add(true);
    });
  }

  @override
  void dispose() {
    retrieveSMSController.close();
    retrieveSMSCompleteController.close();
  }
}

class QuerySMSCounterPercentage extends BaseBloc {

  StreamController<int> percentageProcessController = StreamController<int>();
  Stream<int> get percentageProcessStream => percentageProcessController.stream;
  StreamSink<int> get percentageProcessSink => percentageProcessController.sink;

  @override
  void dispose() {
    percentageProcessController.close();
  }
}

QuerySMSCounterPercentage counterPercentage = QuerySMSCounterPercentage();
