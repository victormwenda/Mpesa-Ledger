import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/models/unrecorded_transactions_mode.dart';
import 'package:mpesa_ledger_flutter/repository/unrecorded_transactions_repository.dart';
import 'package:mpesa_ledger_flutter/services/sms_filter/index.dart';

class UnrecordedTransactionsBloc extends BaseBloc {
  SMSFilter _smsFilter = SMSFilter();

  bool timerWait = false;

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
      _insertToDB();
    });
  }

  _insertToDB() async {
    if (!timerWait) {
      timerWait = true;
      var result = await _getFromDB();
      if (result.isNotEmpty) {
        await _smsFilter.addSMSTodatabase(result);
        homeBloc.getSMSDataSink.add(null);
        for (var i = 0; i < result.length; i++) {
          await _deleteFromDB(result[i]["id"].toString());
        }
      }
      timerWait = false;
    }
  }

  Future<List<Map<dynamic, dynamic>>> _getFromDB() async {
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
