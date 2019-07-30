import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/unknown_transaction_model.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class UnknownTransactionRepository {
  String tableName = unknownTransactionsTable;

  Future<Database> get database async {
    return await databaseProvider.database;
  }

  Future<int> insert(
      UnknownTransactionsModel unknownTransaction) async {
    var db = await database;
    return await db.insert(tableName, unknownTransaction.toMap());
  }

  Future<List<UnknownTransactionsModel>> select() async {
    var db = await database;
    List<Map<String, dynamic>> result;
    result = await db.query(tableName);
    List<UnknownTransactionsModel> unknownTransactions = result.isNotEmpty
        ? result.map((data) => UnknownTransactionsModel.fromMap(data)).toList()
        : [];
    return unknownTransactions;
  }

  Future<int> count() async {
    var db = await database;
    return Sqflite
    .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

}
