import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  String tableName = categoriesTable;

  Future<Database> get database async {
    return await _databaseProvider.database;
  }

  Future<List<CategoryModel>> getAll(List<String> columns,
      {String query}) async {
    var db = await database;
    List<Map<String, dynamic>> result;
    result = await db.query(tableName, columns: columns);
    List<CategoryModel> categories = result.isNotEmpty
        ? result.map((data) => CategoryModel.fromMap(data)).toList()
        : [];
    return categories;
  }
}
