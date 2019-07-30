import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';

class SearchBloc extends BaseBloc {

  TransactionRepository _transactionRepository = TransactionRepository();
  HomeBloc _homeBloc = HomeBloc();

  StreamController<List<Map<String, dynamic>>> searchController = StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get searchStream => searchController.stream;
  StreamSink<List<Map<String, dynamic>>> get searchSink => searchController.sink;

  // EVENT

  StreamController<String> searchEventController = StreamController<String>.broadcast();
  Stream<String> get searchEventStream => searchEventController.stream;
  StreamSink<String> get searchEventSink => searchEventController.sink;

  SearchBloc() {
    searchEventStream.listen((data) async {
      List<TransactionModel> result = [];
      if (data.isNotEmpty) {
        result = await _transactionRepository.select(query: data);
        searchSink.add(await _homeBloc.getTransactions(transactions: result));
      } else {
        searchSink.add([]);
      }
    });
  }

  @override
  void dispose() {
    
  }
  
}

SearchBloc searchBloc = SearchBloc();