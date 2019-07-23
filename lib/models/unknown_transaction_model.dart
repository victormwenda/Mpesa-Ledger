import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart'
    as regexString;
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class UnknownTransactionsModel {
  int id;
  String body;
  int timestamp;
  double mpesaBalance;
  List<double> amounts;
  double transactionCost;
  String transactionId;

  UnknownTransactionsModel.fromMap(Map<String, dynamic> map) {
    body = map["body"];
    timestamp = map["timestamp"];
    mpesaBalance = map["mpesaBalance"];
    if (map["amounts"] is List<double>) {
      amounts = map["amounts"];
    } else {
      amounts = RegexUtil(regexString.amount, map["amounts"])
          .getAllMatchResults
          .map(double.parse)
          .toList();
    }
    transactionCost = map["transactionCost"];
    transactionId = map["transactionId"];
    id = map["id"] ?? null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "body": body,
      "timestamp": timestamp,
      "mpesaBalance": mpesaBalance,
      "amounts": amounts.toString(),
      "transactionCost": transactionCost,
      "transactionId": transactionId
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
