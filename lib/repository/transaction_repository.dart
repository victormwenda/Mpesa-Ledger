import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/base_repository.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqlite_api.dart';

class TransactionRepository extends BaseRepository {
  String tableName = transactionsTable;

  @override
  Future<Database> get database async => await databaseProvider.database;

  Future<int> insert(TransactionModel transaction) async {
    var db = await database;
    return await db.insert(tableName, transaction.toMap());
  }

  Future<List<TransactionModel>> select({String query}) async {
    var db = await database;
    List<Map<String, dynamic>> result;
    if (query != null && query.isNotEmpty) {
      result = await db.query(
        tableName,
        where: "id = ?",
        whereArgs: ["$query"],
      );
    } else {
      result = await db.rawQuery('''
        SELECT * FROM $tableName
        ORDER BY
        timestamp DESC;
      ''');
    }
    List<TransactionModel> transactions = result.isNotEmpty
        ? result.map((data) => TransactionModel.fromMap(data)).toList()
        : [];
    return transactions;
  }

  Future<List<TransactionModel>> selectByKeyword(String schema) async {
    var db = await database;
    List<Map<String, dynamic>> result;
    result = await db.query(
      tableName,
      where: "?",
      whereArgs: [schema],
    );
    List<TransactionModel> transactions = result.isNotEmpty
        ? result.map((data) => TransactionModel.fromMap(data)).toList()
        : [];
    return transactions;
  }

  Future<List<TransactionModel>> searchTransaction(String query) async {
    var db = await database;
    List<Map<String, dynamic>> result;
    result = await db.query(
      tableName,
      where: "body LIKE ?",
      whereArgs: ["%$query%"],
    );
    List<TransactionModel> transactions = result.isNotEmpty
        ? result.map((data) => TransactionModel.fromMap(data)).toList()
        : [];
    return transactions;
  }
}
