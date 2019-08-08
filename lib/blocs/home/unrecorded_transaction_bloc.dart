import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/models/unrecorded_transactions_mode.dart';
import 'package:mpesa_ledger_flutter/repository/unrecorded_transactions_repository.dart';
import 'package:mpesa_ledger_flutter/services/sms_filter/index.dart';

class UnrecordedTransactionsBloc extends BaseBloc {
  SMSFilter _smsFilter = SMSFilter();

  bool triggerInsert = true;

  UnrecordedTransactionsRepository _unrecordedTransactionsRepository =
      UnrecordedTransactionsRepository();

  // EVENTS

  StreamController _insertUnrecordedTransactionsToDB = StreamController();
  Stream get insertUnrecordedTransactionsToDBStream =>
      _insertUnrecordedTransactionsToDB.stream;
  StreamSink get insertUnrecordedTransactionsToDBSink =>
      _insertUnrecordedTransactionsToDB.sink;

  UnrecordedTransactionsBloc() {
    insertUnrecordedTransactionsToDBStream.listen((void data) {
      if (triggerInsert) {
        _insertToDB();
      }
    });
  }

  _insertToDB() async {
    triggerInsert = false;
    print("trigger started");
    var result = await _getFromDB();
    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        print(result[i]);
      }
      await _smsFilter.addSMSTodatabase(result.reversed.toList());
      print("DONE INSERTING");
      for (var i = 0; i < result.length; i++) {
        await _deleteFromDB(result[i]["id"].toString());
      }
      print("DONE DELETING");
      homeBloc.getSMSDataSink.add(null);
      triggerInsert = true;
    } else {
      print("trigger ended");
      triggerInsert = true;
    }
  }

  Future<List<dynamic>> _getFromDB() async {
    List<Map<dynamic, dynamic>> listMap = [];
    var result = await _unrecordedTransactionsRepository.select();
    for (var i = 0; i < result.length; i++) {
      listMap.add(result[i].toMap());
    }
    return listMap;
  }

  _deleteFromDB(String id) async {
    await _unrecordedTransactionsRepository.delete(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
