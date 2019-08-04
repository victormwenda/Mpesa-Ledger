import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/recase.dart';

class NewCategoryBloc extends BaseBloc {
  List<String> keywordList = [];

  StreamController<List<String>> _keyWordChipController =
      StreamController<List<String>>();
  Stream<List<String>> get keyWordChipStream => _keyWordChipController.stream;
  StreamSink<List<String>> get keyWordChipSink => _keyWordChipController.sink;

  StreamController _totalTransactionsController = StreamController();
  Stream get totalTransactionsStream => _totalTransactionsController.stream;
  StreamSink get totalTransactionsSink => _totalTransactionsController.sink;

  // EVENTS

  StreamController<String> _addKeywordController = StreamController<String>();
  Stream<String> get addKeywordStream => _addKeywordController.stream;
  StreamSink<String> get addKeywordSink => _addKeywordController.sink;

  StreamController<int> _deleteKeywordController = StreamController<int>();
  Stream<int> get deleteKeywordStream => _deleteKeywordController.stream;
  StreamSink<int> get deleteKeywordSink => _deleteKeywordController.sink;

  NewCategoryBloc() {
    addKeywordStream.listen((data) {
      _addKeyword(data);
      
    });
    deleteKeywordStream.listen((data) {
      _deleteKeyword(data);
    });
  }

  String _generateSchema() {
    if (keywordList.isNotEmpty) {
      String s = "";
      for (var i = 0; i < keywordList.length; i++) {
        var index = keywordList[i];
        s += "body LIKE '%$index%' OR ";
      }
      return s.replaceRange(s.length - 4, s.length, "");
    }
    return "";
  }

  _addKeyword(String keyword) {
    if (!keywordList.contains(keyword)) {
      keywordList.add(keyword);
      keyWordChipSink.add(keywordList);
    }
  }

  _deleteKeyword(int index) {
    keywordList.removeAt(index);
    keyWordChipSink.add(keywordList);
  }

  @override
  void dispose() {}
}
