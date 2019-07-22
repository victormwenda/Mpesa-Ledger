import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/mpesa_balance_model.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class MpesaBalanceRepository {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  String tableName = mpesaBalanceTable;

  Future<Database> get database async {
    return await _databaseProvider.database;
  }

  Future<int> update(MpesaBalanceModel mpesaBalance) async {
    var db = await database;
    return await db.update(
      tableName,
      mpesaBalance.toMap(),
      where: "id = ?",
      whereArgs: [mpesaBalance.id]
    );
  }
}
