import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/sms_filter/index.dart';
import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class QuerySMSBloc extends BaseBloc{

  var methodChannel = MethodChannelClass();
  SMSFilter smsFilter = SMSFilter();

  StreamController<void> retrieveSMSController =
      StreamController<void>.broadcast();
  Stream<void> get retrieveSMSStream =>
      retrieveSMSController.stream;
  StreamSink<void> get retrieveSMSSink =>
      retrieveSMSController.sink;

  Future<List<dynamic>> retrieveSMSMessages() async {
    var result = await methodChannel.invokeMethod("retrieveSMSMessages");
    return result;
  }

  QuerySMSBloc() {
    retrieveSMSStream.listen((void data) async {
      var result = await smsFilter.addSMSTodatabase(await retrieveSMSMessages());
    });
  }

  @override
  void dispose() {
    retrieveSMSController.close();
  }
}
