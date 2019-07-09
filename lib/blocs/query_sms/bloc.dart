import 'dart:async';
import 'package:flutter/services.dart';

import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class QuerySMS {

  var methodChannel = MethodChannelClass();

  StreamController<List<dynamic>> readSMSController =
      StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get readSMSStream =>
      readSMSController.stream;
  StreamSink<List<dynamic>> get readSMSSink =>
      readSMSController.sink;

  QuerySMS() {
  }

  Future<List<dynamic>> getAllSMSMessages() async {
    var result = await methodChannel.invokeMethod("getAllSMSMessages");
    readSMSSink.add(result);
    return result;
  }

  Future<void> _handleCallsFromNative(MethodCall call) async {
    switch (call.method) {
    }
  }

  void dispose() {
    readSMSController.close();
  }
}
