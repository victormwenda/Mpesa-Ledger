import 'dart:core';

import 'package:mpesa_ledger_flutter/blocs/query_sms/query_sms_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_category_model.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/models/unknown_transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/category_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_category_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';
import 'package:mpesa_ledger_flutter/repository/unknown_transaction_repository.dart';
import 'package:mpesa_ledger_flutter/sms_filter/check_sms_category.dart';
import 'package:mpesa_ledger_flutter/sms_filter/check_sms_type.dart';

class SMSFilter {
  CheckSMSType smsFilters;

  TransactionRepository transactionRepo = TransactionRepository();
  UnknownTransactionRepository unknownTransactionRepo =
      UnknownTransactionRepository();
  CategoryRepository categoryRepo = CategoryRepository();
  TransactionCategoryRepository transactionCategoryRepo =
      TransactionCategoryRepository();

  Future<Map<String, String>> addSMSTodatabase(List<dynamic> bodies) async {
    try {
      var categoryObject =
          await categoryRepo.getAll(["id", "keywords"]);
      int bodyLength = bodies.length;
      for (var i = 0; i < bodyLength; i++) {
        var obj = await getSMSObject(bodies[i]["body"], bodies[i]["timestamp"]);
        if (obj.isNotEmpty) {
          if (obj["data"].containsKey("amounts")) {
            await unknownTransactionRepo.insert(
              UnknownTransactionsModel.fromMap(obj["data"]),
            );
          } else {
            int id = await transactionRepo.insert(
              TransactionModel.fromMap(obj["data"]),
            );
            var transactionCategoryObjectList =
                await CheckSMSCategory(categoryObject, obj["data"]["body"], id)
                    .addCategeoryToTransaction();
                    print(transactionCategoryObjectList);
            for (var j = 0; j < transactionCategoryObjectList.length; j++) {
              await transactionCategoryRepo.insert(
                TransactionCategoryModel.fromMap(transactionCategoryObjectList[j]),
              );
            }
          }
        }
        counterPercentage.percentageProcessSink.add(((i/bodyLength)*100).round());
      }
      print("FINISHED ADDIND ALL TO DATABASE");
      return {
        "success": "Data successfully added to database"
      };
    } catch (e) {
      print(e);
      return {
        "error": "There was an error",
        "msg": e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> getSMSObject(
      String body, String timestamp) async {
    Map<String, dynamic> smsObject = {};
    smsFilters = CheckSMSType(body, timestamp);
    var coreValuesObject = await smsFilters.getCoreValues();
    if (!coreValuesObject.containsKey("error")) {
      smsObject.addAll(coreValuesObject);
      await smsObject["data"].addAll(smsFilters.checkTypeOfSMS());
    }
    return Future.value(smsObject);
  }
}
