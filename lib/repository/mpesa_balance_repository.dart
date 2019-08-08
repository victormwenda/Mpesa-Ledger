import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/mpesa_balance_model.dart';
import 'package:mpesa_ledger_flutter/repository/base_repository.dart';
import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class MpesaBalanceRepository extends BaseRepository{
  String tableName = mpesaBalanceTable;

  @override
  Future<Database> get database async => await databaseProvider.database;

  Future<MpesaBalanceModel> select() async {
    var db = await database;
    List<Map<String, dynamic>> result;
    result = await db.query(tableName);
    List<MpesaBalanceModel> mpesaBalance = result.isNotEmpty
        ? result.map((data) => MpesaBalanceModel.fromMap(data)).toList()
        : [];
    return mpesaBalance[0];
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
