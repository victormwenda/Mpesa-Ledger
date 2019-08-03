import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/models/transaction_category_model.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/category_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_category_repository.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';

class CategoriesBloc extends BaseBloc {
  CategoryRepository _categoryRepository = CategoryRepository();
  TransactionCategoryRepository _transactionCategoryRepository =
      TransactionCategoryRepository();
  TransactionRepository _transactionRepository = TransactionRepository();

  List<Map<String, dynamic>> _listCategoriesMap = [];
  Map<String, dynamic> _categoryTotalsMap = {};
  List<Map<String, dynamic>> _listTransactionsMap = [];

  StreamController<List<Map<String, dynamic>>> _categoriesController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get categoriesStream =>
      _categoriesController.stream;
  StreamSink<List<Map<String, dynamic>>> get categoriesSink =>
      _categoriesController.sink;

  StreamController<Map<String, dynamic>> _transactionsController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get transactionsStream =>
      _transactionsController.stream;
  StreamSink<Map<String, dynamic>> get transactionsSink =>
      _transactionsController.sink;

  // EVENTS
  StreamController<String> _getTransactionsController =
      StreamController<String>();
  Stream<String> get getTransactionsStream =>
      _getTransactionsController.stream;
  StreamSink<String> get getTransactionsSink =>
      _getTransactionsController.sink;


  CategoriesBloc() {
    _getCategories();
    getTransactionsStream.listen((data) {
      _getTransactions(data);
    });
  }

  Future<void> _getCategories() async {
    var result = await _categoryRepository.select();
    for (var i = 0; i < result.length; i++) {
      _listCategoriesMap.add(result[i].toMap());
    }
    categoriesSink.add(_listCategoriesMap);
  }

  _getTransactions(String id) async {
    double deposits = 0;
    double withdrawals = 0;
    double transactionCosts = 0;
    List<TransactionCategoryModel> transactionCategory =
        await _transactionCategoryRepository.selectCategories(query: id);
    for (var i = 0; i < transactionCategory.length; i++) {
      List<TransactionModel> transaction = await _transactionRepository.select(
          query: transactionCategory[i].transactionId.toString());
      if (transaction[0].isDeposit) {
        deposits += transaction[0].amount;
      } else {
        withdrawals += transaction[0].amount;
      }
      transactionCosts += transaction[0].transactionCost;
      _listTransactionsMap.add(transaction[0].toMap());
    }
    _categoryTotalsMap = {
      "deposits": deposits,
      "withdrawals": withdrawals,
      "transactionCosts": transactionCosts
    };
    transactionsSink.add(
      {"transactions": _listTransactionsMap, "totals": _categoryTotalsMap},
    );
  }

  @override
  void dispose() {}
}
