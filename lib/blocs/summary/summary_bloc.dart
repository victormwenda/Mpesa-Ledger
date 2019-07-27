import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/summary_model.dart';
import 'package:mpesa_ledger_flutter/repository/summary_repository.dart';

class SummaryBloc extends BaseBloc {
  SummaryRepository _summaryRepository = SummaryRepository();

  StreamController<Map<String, dynamic>> _transactionTotalsController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get transactionTotalsStream =>
      _transactionTotalsController.stream;
  StreamSink<Map<String, dynamic>> get transactionTotalsSink =>
      _transactionTotalsController.sink;

  SummaryBloc() {
    _getSummary();
  }

  Future<void> _getSummary() async {
    List<SummaryModel> result = await _summaryRepository.select();
    Map<String, dynamic> map = {};
    map["totals"] = _getTotal(result);
    map["yearMonthlyTotals"] = _getYearMonthlyTotals(result);
    transactionTotalsSink.add(map);
  }

  Map<String, double> _getTotal(List<SummaryModel> list) {
    double totalDeposits = 0;
    double totalWithdraws = 0;
    double totalTransactionCosts = 0;
    Map<String, double> map = {};
    for (var i = 0; i < list.length; i++) {
      totalDeposits += list[i].toMap()["deposits"];
      totalWithdraws += list[i].toMap()["withdrawals"];
      totalTransactionCosts += list[i].toMap()["transactionCost"];
    }
    map["deposits"] = totalDeposits;
    map["withdrawals"] = totalWithdraws;
    map["transactionCost"] = totalTransactionCosts;
    return map;
  }

  List<Map<String, dynamic>> _getYearMonthlyTotals(List<SummaryModel> list) {
    List<Map<String, dynamic>> listMap = [];
    Set<int> yearSet = _getYearSet(list);
    yearSet.forEach(
      (data) {
        Map<String, dynamic> yearMap = {};
        List<Map<String, dynamic>> monthlyTotalsList = [];
        yearMap["year"] = data;
        for (var i = 0; i < list.length; i++) {
          Map<String, dynamic> monthlyTotalsMap = {};
          if (data == list[i].toMap()["year"]) {
            monthlyTotalsMap["deposits"] = list[i].toMap()["deposits"];
            monthlyTotalsMap["withdrawals"] = list[i].toMap()["withdrawals"];
            monthlyTotalsMap["transactionCost"] =
                list[i].toMap()["transactionCost"];
            monthlyTotalsMap["month"] = list[i].toMap()["month"];
          }
          monthlyTotalsList.add(monthlyTotalsMap);
        }
        yearMap["monthlyTotals"] = monthlyTotalsList;
        listMap.add(yearMap);
      },
    );
    return listMap;
  }

  _getYearSet(List<SummaryModel> list) {
    List<int> years = [];
    for (var i = 0; i < list.length; i++) {
      print(list[i].toMap());
      years.add(list[i].toMap()["year"]);
    }
    return years.toSet();
  }

  @override
  void dispose() {
    _transactionTotalsController.close();
  }
}
