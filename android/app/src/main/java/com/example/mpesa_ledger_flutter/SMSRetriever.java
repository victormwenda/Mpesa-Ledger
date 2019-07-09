package com.example.mpesa_ledger_flutter;

import android.database.Cursor;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SMSRetriever {
  Cursor cursor;

  public SMSRetriever(Cursor cursor) {
    this.cursor = cursor;
  }

  List<Map<String, Object>> getAllSMSMessages() {
    List<Map<String, Object>> mapList = new ArrayList<>();

    while (cursor.moveToNext()) {
      Map<String, Object> map = new HashMap<>();
      map.put("date", cursor.getString(cursor.getColumnIndexOrThrow("date")));
      map.put("body", cursor.getString(cursor.getColumnIndexOrThrow("body")));
      mapList.add(map);
      Log.e("MPESA", cursor.getString(cursor.getColumnIndexOrThrow("address")));
    }

    return mapList;
  }
}
