import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MpesaLedger.db');

    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
    });

    return db;
  }
}