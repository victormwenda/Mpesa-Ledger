import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/summary_model.dart';
import 'package:mpesa_ledger_flutter/repository/summary_repository.dart';

class SummaryBloc extends BaseBloc {
  SummaryRepository _summaryRepository = SummaryRepository();

  StreamController<Map<String, double>> _transactionTotalsController =
      StreamController<Map<String, double>>();
  Stream<Map<String, double>> get transactionTotalsStream =>
      _transactionTotalsController.stream;
  StreamSink<Map<String, double>> get transactionTotalsSink =>
      _transactionTotalsController.sink;

  SummaryBloc() {
    _getSummary();
  }

  Future<void> _getSummary() async {
    List<SummaryModel> result = await _summaryRepository.select();
    transactionTotalsSink.add(_getTotal(result));
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

  @override
  void dispose() {
    _transactionTotalsController.close();
  }
}
