import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class DateFormatUtil {
  var methodChannel = MethodChannelClass();

  int get getCurrentTimestamp {
    return DateTime.now().millisecondsSinceEpoch;
  }

  Future<int> getTimestamp(String dateTime) async {
    var methodChannel = MethodChannelClass();
    String timestamp = await methodChannel.invokeMethod("changeStringToTimestamp",
        argument: {"dateTime": dateTime});
    return int.parse(timestamp);
  }

  Future<Map<dynamic, dynamic>> getDateTime(String timestamp) async {
    var methodChannel = MethodChannelClass();
    return await methodChannel
        .invokeMethod("getDateTime", argument: {"timestamp": timestamp});
  }
}
