import 'dart:async';

import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initializedDatabase();
    return _database;
  }

  Future<String> databasePath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, databaseName);
  }

  Future<Database> initializedDatabase() async {
    String path = await databasePath();
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        for (var i = 0; i < schema.length; i++) {
          await db.execute(schema[i]);
        }
      },
    );
    return database;
  }

  void closeDatabase() async {
    if (_database != null) {
      _database.close();
    }
    _database = null;
  }

  void deleteDB() async {
    String path = await databasePath();
    deleteDatabase(path);
    _database = null;
  }
}

DatabaseProvider databaseProvider = DatabaseProvider();
