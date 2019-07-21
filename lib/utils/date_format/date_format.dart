import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class DateFormatUtil {
  var methodChannel = MethodChannelClass();

  Future<int> getTimestamp(String dateTime) async {
    var methodChannel = MethodChannelClass();
    int timestamp = await methodChannel.invokeMethod("changeStringToTimestamp",
        argument: {"dateTime": dateTime});
    return timestamp;
  }

  int get getCurrentTimestamp {
    return (DateTime.now().millisecondsSinceEpoch / 1000).round();
  }

  Future<Map<dynamic, dynamic>> getDateTime(String timestamp) async {
    var methodChannel = MethodChannelClass();
    return await methodChannel
        .invokeMethod("getDateTime", argument: {"timestamp": timestamp});
  }
}
