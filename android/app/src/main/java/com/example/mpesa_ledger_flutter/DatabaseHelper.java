package com.example.mpesa_ledger_flutter;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.List;
import java.util.Map;

public class DatabaseHelper extends SQLiteOpenHelper {

  final String tableName = "unrecordedTransactions";

  public DatabaseHelper(Context context) {
    super(context, "MpesaLedger.db", null, 1);
  }

  DatabaseHelper insertUnrecordedTransactions(List<Map<String, String>> mapList) {
    SQLiteDatabase sqLiteDatabase = this.getWritableDatabase();
    sqLiteDatabase.beginTransaction();
    for(Map<String, String> map: mapList) {
      ContentValues contentValues = new ContentValues();
      contentValues.put("timestamp", map.get("timestamp"));
      contentValues.put("body", map.get("body"));
      sqLiteDatabase.insert(tableName, null, contentValues);
    }
    sqLiteDatabase.setTransactionSuccessful();
    sqLiteDatabase.endTransaction();
    sqLiteDatabase.close();
    return null;
  }

  @Override
  public void onOpen(SQLiteDatabase db) {
    super.onOpen(db);
  }

  @Override
  public void onCreate(SQLiteDatabase sqLiteDatabase) {}

  @Override
  public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {}
}
