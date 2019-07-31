import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/repository/unknown_transaction_repository.dart';
import 'package:mpesa_ledger_flutter/services/sms_filter/index.dart';

class UnknownTransactionsBloc extends BaseBloc {
  UnknownTransactionRepository _unknownTransactionRepository =
      UnknownTransactionRepository();
  SMSFilter _smsFilter = SMSFilter();

  Map<dynamic, dynamic> transactionMap = {};

  StreamController<List<Map<String, dynamic>>> _unknownTransactionsController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get unknownTransactionStream =>
      _unknownTransactionsController.stream;
  StreamSink<List<Map<String, dynamic>>> get unknownTransactionSink =>
      _unknownTransactionsController.sink;

  StreamController<Map<dynamic, dynamic>> _unknownTransactionsMapController =
      StreamController<Map<dynamic, dynamic>>.broadcast();
  Stream<Map<dynamic, dynamic>> get unknownTransactionMapStream =>
      _unknownTransactionsMapController.stream;
  StreamSink<Map<dynamic, dynamic>> get unknownTransactionMapSink =>
      _unknownTransactionsMapController.sink;

  // EVENTS

  StreamController<void> _getUnknownTransactionsEventController =
      StreamController<void>();
  Stream<void> get getUnknownTransactionEventStream =>
      _getUnknownTransactionsEventController.stream;
  StreamSink<void> get getUnknownTransactionEventSink =>
      _getUnknownTransactionsEventController.sink;

  StreamController<Map<dynamic, dynamic>>
      _unknownTransactionsMapEventController =
      StreamController<Map<dynamic, dynamic>>.broadcast();
  Stream<Map<dynamic, dynamic>> get unknownTransactionMapEventStream =>
      _unknownTransactionsMapEventController.stream;
  StreamSink<Map<dynamic, dynamic>> get unknownTransactionMapEventSink =>
      _unknownTransactionsMapEventController.sink;

  StreamController<int>
      _unknownTransactionsInsertEventController =
      StreamController<int>.broadcast();
  Stream<int> get unknownTransactionInsertEventStream =>
      _unknownTransactionsInsertEventController.stream;
  StreamSink<int> get unknownTransactionInsertEventSink =>
      _unknownTransactionsInsertEventController.sink;

  UnknownTransactionsBloc() {
    getUnknownTransactionEventStream.listen((data) {
      _getUnknownTransactions();
    });
    unknownTransactionMapEventStream.listen((data) {
      transactionMap.addAll(data);
      unknownTransactionMapSink.add(transactionMap);
    });
    unknownTransactionInsertEventStream.listen((data) {
      _insertUnknownTransaction(data);
    });
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
    unknownTransactionSink.add(listMap.reversed.toList());
  }

  _insertUnknownTransaction(int id) async {
    transactionMap.remove("id");
    transactionMap.remove("amounts");
    List<Map<String, dynamic>> listMap = [];
    Map<String, dynamic> map = {};
    map["data"] = transactionMap;
    listMap.add(map);
    var result = await _smsFilter
        .addSMSTodatabase(listMap, fromQueryBloc: false);
    if (result.containsKey("success")) {
      _deleteUnknownTransaction(id);
    }
  }

  _deleteUnknownTransaction(int id) async {
    await _unknownTransactionRepository.delete(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
