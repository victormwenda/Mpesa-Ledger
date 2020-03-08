import 'dart:core';

import 'package:mpesa_ledger_flutter/blocs/counter/counter_bloc.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/models/mpesa_balance_model.dart';
import 'package:mpesa_ledger_flutter/models/summary_model.dart';
import 'package:mpesa_ledger_flutter/models/transaction_category_model.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/category_repository.dart';
import 'package:mpesa_ledger_flutter/repository/mpesa_balance_repository.dart';
import 'package:mpesa_ledger_flutter/repository/summary_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_category_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';
import 'package:mpesa_ledger_flutter/services/sms_filter/check_sms_category.dart';
import 'package:mpesa_ledger_flutter/services/sms_filter/check_sms_type.dart';

class SMSFilter {
  CheckSMSType smsFilters;
  TransactionRepository transactionRepo = TransactionRepository();
  CategoryRepository categoryRepo = CategoryRepository();
  TransactionCategoryRepository transactionCategoryRepo =
      TransactionCategoryRepository();
  SummaryRepository summaryRepo = SummaryRepository();
  MpesaBalanceRepository mpesaBalanceRepository = MpesaBalanceRepository();

  var bosiesTest = [
    {
      "body":
          "OC36I5RICG Confirmed. Ksh10.00 sent to Naivas for account acc_12345 on 5/1/20 at 9:30 pm New M-PESA balance is Ksh980. Transaction cost, Ksh10.00",
      "timestamp": 1578205800000
    },
    {
      "body":
          "NC36I5RICG Confirmed. Ksh50.00 sent to Jama Mohamed 0790749401 on. New M-PESA balance is Ksh923.00. Transaction cost, Ksh7.00.",
      "timestamp": 1579059180000
    },
    {
      "body":
          "OC3695RICG Confirmed. Ksh5.00 paid to uCHUMI. on 15/1/20 at 12:02 PM. New M-PESA balance is Ksh918.00. Transaction cost, Ksh0.00.",
      "timestamp": 1579078920000
    },
    {
      "body":
          "OX36I5RICG confirmed. You bought Ksh3.00 of airtime on 15/1/20 at 4:15pm. New M-PESA balance is Ksh915.00. Transaction cost, Ksh0.00.",
      "timestamp": 1579094100000
    },
    {
      "body":
          "OC3695RICG Confirmed. On 22/1/20 at 1:12pm Give Ksh100.00 cash to Fontana New M-PESA balance is Ksh1015.00",
      "timestamp": 1579687920000
    },
    {
      "body":
          "NC36I5RICG Confirmed. on 3/2/20 at 3:33 pmWithdraw Ksh200.00 from 321321 - Fontana New M-PESA balance is Ksh800.00. Transaction cost, Ksh15.00.",
      "timestamp": 1580733180000
    },
    {
      "body":
          "OX36I5RICG Confirmed. Ksh220.00 sent to Jon Doe 254712345678 on 4/2/20 at 10:24 am. New M-PESA balance is Ksh560.00. Transaction cost, Ksh20.00.",
      "timestamp": 1580801040000
    },
    {
      "body":
          "OC3695RICG Confirmed. You have received Ksh550.00 from DIANA DOE 0712345876 on 12/2/20 at 7:23AM  New M-PESA balance is Ksh1,110.00.",
      "timestamp": 1581481380000
    },
    {
      "body":
          "NC36I5RICG confirmed. Reversal of transaction OC3695RICG has been successfully reversed on 12/2/20 at 12:33am and Ksh220.00 is credited to your M-PESA account. New M-PESA account balance is Ksh1,330.00",
      "timestamp": 1581456780000
    },
    {
      "body":
          "OX36I5RICG Confirmed.Ksh220.00 transferred to M-Shwari account on 13/2/20 at 3:33pm. M-PESA balance is Ksh1,110.00 .New M-Shwari saving account balance is Ksh330.00. Transaction cost Ksh0.00",
      "timestamp": 1581597180000
    },
    {
      "body":
          "OC3695RICG Confirmed.Ksh220.00 transferred from M-Shwari account on 14/2/20 at 5:23PM. M-Shwari balance is Ksh110.00 .M-PESA balance is Ksh1,330.00 .Transaction cost Ksh0.00",
      "timestamp": 1581690180000
    },
    {
      "body":
          "NC36I5RICGConfirmed.  Ksh10.00 transfered to KCB M-PESA account on 22/2/20 at 3:30AM. New M-PESA balance is Ksh1,320.00, new KCB M-PESA Saving account balance is Ksh20.00.",
      "timestamp": 1582331400000
    },
    {
      "body":
          "OX36I5RICGConfirmed. Ksh10.00 transfered from KCB M-PESA account on 22/2/20 at 3:32AM. New M-PESA balance is Ksh1,330.00, new KCB M-PESA Saving account balance is Ksh10.00.",
      "timestamp": 1582331520000
    }
  ];

  Future<Map<String, String>> addSMSTodatabase(List<dynamic> bodies) async {
    try {
      bosiesTest = bosiesTest.reversed.toList();
      List<dynamic> reversedBodies = bosiesTest.reversed.toList();
      var categoryObject =
          await categoryRepo.select(columns: ["id", "keywords"]);
      int bodyLength = reversedBodies.length;
      for (var i = 0; i < bodyLength; i++) {
        Map<String, dynamic> obj = await _getSMSObject(reversedBodies[i]);
        if (obj.isNotEmpty && !obj["data"].containsKey("unknown")) {
          int id = await transactionRepo.insert(
            TransactionModel.fromMap(Map<String, dynamic>.from(obj["data"])),
          );
          var transactionCategoryObjectList =
              await CheckSMSCategory(categoryObject, obj["data"]["body"], id)
                  .addCategeoryToTransaction();
          for (var j = 0; j < transactionCategoryObjectList.length; j++) {
            await transactionCategoryRepo.insert(
              TransactionCategoryModel.fromMap(
                  transactionCategoryObjectList[j]),
            );
            await categoryRepo.incrementNumOfTransactions(CategoryModel.fromMap(
                {"id": transactionCategoryObjectList[j]["categoryId"]}));
          }

          await summaryRepo.insert(SummaryModel.fromMap({
            "month": obj["data"]["jiffy"].MMM,
            "monthInt": obj["data"]["jiffy"].month.toString(),
            "year": obj["data"]["jiffy"].year,
            "deposits":
                obj["data"]["isDeposit"] == 1 ? obj["data"]["amount"] : 0.0,
            "withdrawals":
                obj["data"]["isDeposit"] == 0 ? obj["data"]["amount"] : 0.0,
            "transactionCost": obj["data"]["transactionCost"]
          }));
        }
        if (obj.isNotEmpty && obj["data"]["mpesaBalance"] != null) {
          await mpesaBalanceRepository.update(MpesaBalanceModel.fromMap(
              {"mpesaBalance": obj["data"]["mpesaBalance"]}));
        }
        counter.counterSink.add(((i / bodyLength) * 100).round());
      }
      return {"success": "Data successfully added to database"};
    } catch (e) {
      return {"error": "There was an error", "msg": e.toString()};
    }
  }

  Future<Map<String, dynamic>> _getSMSObject(Map<dynamic, dynamic> map) async {
    Map<String, dynamic> smsObject = {};
    smsFilters = CheckSMSType(map["body"], map["timestamp"].toString());
    var coreValuesObject = await smsFilters.getCoreValues();
    if (!coreValuesObject.containsKey("error")) {
      smsObject.addAll(coreValuesObject);
      await smsObject["data"].addAll(smsFilters.checkTypeOfSMS());
    }
    return Future.value(smsObject);
  }
}
