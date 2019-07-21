import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class DateFormatUtil {
  var methodChannel = MethodChannelClass();

  Future<int> getTimestamp(String dateTime) async {
    var methodChannel = MethodChannelClass();
    int timestamp = await methodChannel.invokeMethod("changeStringToTimestamp", argument: {"dateTime": dateTime});
    return timestamp;
  }

  int get getCurrentTimestamp {
    return (DateTime.now().millisecondsSinceEpoch/1000).round();
  }

  int getDay(String timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000).day;
  }

  Future<String> getMonth(String timestamp) {

  }

  int getYear(String timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000).year;
  }
}
