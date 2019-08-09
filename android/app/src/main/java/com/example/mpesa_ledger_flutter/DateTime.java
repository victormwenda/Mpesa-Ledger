package com.example.mpesa_ledger_flutter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import io.flutter.plugin.common.MethodCall;

public class DateTime {
  private MethodCall methodCall;

  public DateTime(MethodCall methodCall) {
    this.methodCall = methodCall;
  }

  String getTimestamp() {
    try {
      SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/yy h:mm a");
      dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
      Date date = dateFormat.parse(methodCall.argument("dateTime"));
      long timestamp = date.getTime();
      return timestamp + "";
    } catch (ParseException e) {
      e.printStackTrace();
      return "0";
    }
  }

  private Object getDateFormat(String s) {
    Calendar c = Calendar.getInstance();
    c.setTimeInMillis(Long.parseLong(methodCall.argument("timestamp")));
    Date date = c.getTime();
    DateFormat dateFormat = new SimpleDateFormat(s);
    dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
    return dateFormat.format(date);
  }

  Map<String, Object> getDateTime() {
    Map<String, Object> map = new HashMap<>();
    map.put("time", getDateFormat("h:mm a"));
    map.put("dayString", getDateFormat("EEEE"));
    map.put("dayInt", getDateFormat("d"));
    map.put("month", getDateFormat("MMM"));
    map.put("monthInt", getDateFormat("MM"));
    map.put("year", getDateFormat("yyyy"));
    map.put("dateTime", getDateFormat("d MMM yyyy, h:mm a"));
    return  map;
  }
}
