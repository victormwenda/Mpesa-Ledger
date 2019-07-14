package com.example.mpesa_ledger_flutter;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import java.util.List;
import java.util.Map;

public class DatabaseHelper extends SQLiteOpenHelper {

  final String tableName = "unrecordedMessages";

  public DatabaseHelper(Context context) {
    super(context, "MpesaLedger.db", null, 1);
//    this.context = context;
  }

  DatabaseHelper insertToDatabase(List<Map<String, String>> mapList) {
    SQLiteDatabase sqLiteDatabase = this.getWritableDatabase();
    sqLiteDatabase.beginTransaction();
    for(Map<String, String> map: mapList) {
      ContentValues contentValues = new ContentValues();
      contentValues.put("address", map.get("address"));
      contentValues.put("body", map.get("body"));
      sqLiteDatabase.insert(tableName, null, contentValues);
    }
    Log.d("MPESA db", "ADDED TO DB");
    sqLiteDatabase.setTransactionSuccessful();
    sqLiteDatabase.endTransaction();
    sqLiteDatabase.close();
    return null;
  }

  @Override
  public void onOpen(SQLiteDatabase db) {
    super.onOpen(db);
    Log.d("MPESA db", "ON OPEN");
  }

  @Override
  public void onCreate(SQLiteDatabase sqLiteDatabase) {
    Log.d("MPESA db", "ON CREATE");
  }

  @Override
  public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
    Log.d("MPESA db", "ON UPGRADE");
  }
}
