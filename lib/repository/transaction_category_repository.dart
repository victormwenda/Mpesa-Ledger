import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/transaction_category_model.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class TransactionCategoryRepository {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  String tableName = transactionCategoryTable;

  Future<Database> get database async {
    return await _databaseProvider.database;
  }

  Future<int> insert(TransactionCategoryModel transactionCategory) async {
    var db = await database;
    return await db.insert(tableName, transactionCategory.toMap());
  }
}
