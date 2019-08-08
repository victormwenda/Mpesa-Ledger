import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';

class SearchBloc extends BaseBloc {

  TransactionRepository _transactionRepository = TransactionRepository();

  StreamController<List<Map<String, dynamic>>> _searchController = StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get searchStream => _searchController.stream;
  StreamSink<List<Map<String, dynamic>>> get searchSink => _searchController.sink;

  // EVENT

  StreamController<String> _searchEventController = StreamController<String>();
  Stream<String> get searchEventStream => _searchEventController.stream;
  StreamSink<String> get searchEventSink => _searchEventController.sink;

  SearchBloc() {
    searchEventStream.listen((data) async {
      List<TransactionModel> result = [];
      if (data.isNotEmpty) {
        result = await _transactionRepository.searchTransaction(data);
        searchSink.add(await homeBloc.getTransactions(transactions: result));
      } else {
        searchSink.add([]);
      }
    });
  }

  @override
  void dispose() {
    _searchController.close();
    _searchEventController.close();
  }
  
}

SearchBloc searchBloc = SearchBloc();