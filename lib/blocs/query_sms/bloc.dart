import 'dart:async';

import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class QuerySMS {

  var methodChannel = MethodChannelClass();

  StreamController<List<dynamic>> retrieveSMSController =
      StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get retrieveSMSStream =>
      retrieveSMSController.stream;
  StreamSink<List<dynamic>> get retrieveSMSSink =>
      retrieveSMSController.sink;

  StreamController<List<dynamic>> receiveSMSController =
      StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get receiveSMSStream =>
      receiveSMSController.stream;
  StreamSink<List<dynamic>> get receiveSMSSink =>
      receiveSMSController.sink;

  Future<List<dynamic>> retrieveSMSMessages() async {
    var result = await methodChannel.invokeMethod("retrieveSMSMessages");
    retrieveSMSSink.add(result);
    return result;
  }

  void dispose() {
    retrieveSMSController.close();
    receiveSMSController.close();
  }
}
