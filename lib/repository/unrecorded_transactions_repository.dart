import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/unrecorded_transactions_mode.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class UnrecordedTransactionsRepository {
  String tableName = unrecordedTransactionsTable;

  Future<Database> get database async {
    return await databaseProvider.database;
  }

  Future<List<UnrecordedTransactionsModel>> select() async {
    var db = await database;
    List<Map<String, dynamic>> result;
    result = await db.query(tableName);
    List<UnrecordedTransactionsModel> unrecordedTransactions = result.isNotEmpty
        ? result.map((data) => UnrecordedTransactionsModel.fromMap(data)).toList()
        : [];
    return unrecordedTransactions;
  }

  Future<void> delete(String id) async {
    var db = await database;
    db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
