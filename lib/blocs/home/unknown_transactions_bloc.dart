import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/repository/unknown_transaction_repository.dart';

class UnknownTransactionsBloc extends BaseBloc {
  UnknownTransactionRepository _unknownTransactionRepository =
      UnknownTransactionRepository();

  StreamController<List<Map<String, dynamic>>> _unknownTransactionsController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get unknownTransactionStream => _unknownTransactionsController.stream;
  StreamSink<List<Map<String, dynamic>>> get unknownTransactionSink => _unknownTransactionsController.sink;

  UnknownTransactionsBloc() {
    _getUnknownTransactions();
  }

  Future<void> _getUnknownTransactions() async {
    var result = await _unknownTransactionRepository.select();
    List<Map<String, dynamic>> listMap = [];
    for (var i = 0; i < result.length; i++) {
      Map<String, dynamic> map = {};
      map["id"] = result[i].id;
      map["body"] = result[i].body;
      map["timestamp"] = result[i].timestamp;
      map["mpesaBalance"] = result[i].mpesaBalance;
      map["amounts"] = result[i].amounts;
      map["transactionCost"] = result[i].transactionCost;
      map["transactionId"] = result[i].transactionId;
      listMap.add(map);
    }
    unknownTransactionSink.add(listMap);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
