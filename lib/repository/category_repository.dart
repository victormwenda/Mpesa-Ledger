import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/repository/base_repository.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository extends BaseRepository {
  String tableName = categoriesTable;

  @override
  Future<Database> get database async => await databaseProvider.database;

  Future<int> insert(CategoryModel category) async {
    var db = await database;
    return await db.insert(tableName, category.toMap());
  }

  Future<List<CategoryModel>> select(
      {List<String> columns, String query}) async {
    var db = await database;
    List<Map<String, dynamic>> result;
    if (columns != null && columns.isNotEmpty) {
      if (query != null && query.isNotEmpty) {
        result = await db.query(
          tableName,
          columns: columns,
          where: "id = ?",
          whereArgs: ["$query"],
        );
      } else {
        result = await db.query(tableName, columns: columns);
      }
    } else {
      result = await db.query(tableName);
    }
    List<CategoryModel> categories = result.isNotEmpty
        ? result.map((data) => CategoryModel.fromMap(data)).toList()
        : [];
    return categories;
  }

  Future<void> delete(String id) async {
    var db = await database;
    db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> incrementNumOfTransactions(CategoryModel category) async {
    var db = await database;
    return await db.rawUpdate(
      """
        UPDATE $tableName SET
        numberOfTransactions = numberOfTransactions + 1
        WHERE id = ?;
      """,
      [category.id],
    );
  }
}
