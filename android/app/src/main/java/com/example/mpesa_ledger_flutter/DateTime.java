package com.example.mpesa_ledger_flutter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;

public class DateTime {
  MethodCall methodCall;

  public DateTime(MethodCall methodCall) {
    this.methodCall = methodCall;
  }

  String getTimestamp() {
    try {
      SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/yy h:mm a");
      dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
      Date date = dateFormat.parse(methodCall.argument("dateTime"));
      long timestamp = date.getTime();
      return timestamp + "";
    } catch (ParseException e) {
      e.printStackTrace();
      Log.e("TIMESTAMP", e.getMessage());
      return "0";
    }
  }

  Map<String, Object> getDateTime() {
    Calendar c = Calendar.getInstance();
    c.setTimeInMillis(Long.parseLong(methodCall.argument("timestamp")));

    Date date = c.getTime();

    Map<String, Object> map = new HashMap<>();
    map.put("time", new SimpleDateFormat("h:mm a").format(date));
    map.put("dayString", new SimpleDateFormat("EEEE").format(date));
    map.put("dayInt", new SimpleDateFormat("d").format(date));
    map.put("month", new SimpleDateFormat("MMM").format(date));
    map.put("monthInt", new SimpleDateFormat("MM").format(date));
    map.put("year", new SimpleDateFormat("yyyy").format(date));
    map.put("dateTime", new SimpleDateFormat("d MMM yyyy, h:mm a").format(date));

    return  map;
  }
}
