import 'dart:async';
import "package:collection/collection.dart";

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/repository/mpesa_balance_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';
import 'package:mpesa_ledger_flutter/utils/date_format/date_format.dart';

class HomeBloc extends BaseBloc {
  MpesaBalanceRepository _mpesaBalanceRepository = MpesaBalanceRepository();
  TransactionRepository _transactionRepository = TransactionRepository();

  DateFormatUtil dateFormatUtil = DateFormatUtil();

  StreamController<Map<String, dynamic>> _homeController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get homeStream => _homeController.stream;
  StreamSink<Map<String, dynamic>> get homeSink => _homeController.sink;

  HomeBloc() {
    _getHomeData();
  }

  Future<void> _getHomeData() async {
    Map<String, dynamic> map = {};
    map["headerData"] = {"mpesaBalance": await _getMpesaBalance()};
    map["transactions"] = await _getTransactions();
    homeSink.add(map);
  }

  Future<double> _getMpesaBalance() async {
    var result = await _mpesaBalanceRepository.select();
    return result.mpesaBalance;
  }

  Future<List<Map<String, dynamic>>> _getTransactions() async {
    var result = await _transactionRepository.select();
    List<Map<String, dynamic>> transactionList = [];
    for (var i = 0; i < result.length; i++) {
      var datetime = await dateFormatUtil.getDateTime(result[i].timestamp.toString());
      Map<String, dynamic> transactionMap = {};
      transactionMap["title"] = result[i].title;
      transactionMap["amount"] = result[i].amount;
      transactionMap["isDeposit"] = result[i].isDeposit;
      transactionMap["body"] = result[i].body;
      transactionMap["id"] = result[i].id;
      transactionMap["transactionId"] = result[i].transactionId;
      transactionMap["transactionCost"] = result[i].transactionCost;
      transactionMap["timestamp"] = result[i].timestamp;
      transactionMap["day"] = datetime["dayInt"];
      transactionMap["time"] = datetime["time"];
      transactionList.add(transactionMap);
    }
    var transactionByDayMap = groupBy(transactionList, (key) => key["day"]);
    List<Map<String, dynamic>> transactionByDayList = [];
    transactionByDayMap.forEach((key, value) async {
      var dateTime = await dateFormatUtil.getDateTime(value[0]["timestamp"].toString());
      Map<String, dynamic> map = {};
      map["dateTime"] = {
        "dayInt": key,
        "dayString": dateTime["dayString"],
        "month": dateTime["month"],
        "year": dateTime["year"],
      };
      map["transactions"] = value;
      transactionByDayList.add(map);
    });
    return transactionByDayList;
  }

  @override
  void dispose() {}
}
