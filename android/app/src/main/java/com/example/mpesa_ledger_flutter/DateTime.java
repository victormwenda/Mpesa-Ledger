package com.example.mpesa_ledger_flutter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;

public class DateTime {
  MethodCall methodCall;

  public DateTime(MethodCall methodCall) {
    this.methodCall = methodCall;
  }

  int getTimestamp() {
    try {
      Date date = new SimpleDateFormat("d/M/yy h:mm a").parse(methodCall.argument("dateTime"));
      long timestamp = date.getTime()/1000;
      return (int) timestamp;
    } catch (ParseException e) {
      e.printStackTrace();
      Log.e("TIMESTAMP", e.getMessage());
      return 0;
    }
  }

  String getMonth() {
      Calendar c = Calendar.getInstance();
      c.setTimeInMillis(Long.parseLong(methodCall.argument("timestamp")) * 1000);

      Date date = c.getTime();

      return new SimpleDateFormat("MMM").format(date);
  }

}
