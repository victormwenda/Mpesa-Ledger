import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
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
      StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get categoriesStream =>
      _categoriesController.stream;
  StreamSink<List<Map<String, dynamic>>> get categoriesSink =>
      _categoriesController.sink;

  StreamController<Map<String, dynamic>> _transactionsController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get transactionsStream =>
      _transactionsController.stream;
  StreamSink<Map<String, dynamic>> get transactionsSink =>
      _transactionsController.sink;

  // EVENTS

  StreamController<void> _getCategoriesEventController =
      StreamController<void>();
  Stream<void> get getCategoriesEventStream =>
      _getCategoriesEventController.stream;
  StreamSink<void> get getCategoriesEventSink =>
      _getCategoriesEventController.sink;

  StreamController<String> _getTransactionsEventController =
      StreamController<String>.broadcast();
  Stream<String> get getTransactionsEventStream =>
      _getTransactionsEventController.stream;
  StreamSink<String> get getTransactionsEventSink =>
      _getTransactionsEventController.sink;

  StreamController<String> _deleteCategoryEventController =
      StreamController<String>.broadcast();
  Stream<String> get deleteCategoryEventStream =>
      _deleteCategoryEventController.stream;
  StreamSink<String> get deleteCategoryEventSink =>
      _deleteCategoryEventController.sink;

  CategoriesBloc() {
    getCategoriesEventStream.listen((void data) {
      _getCategories();
    });
    getTransactionsEventStream.listen((data) {
      _getTransactions(data);
    });
    deleteCategoryEventStream.listen((data) {
      _deleteCategory(data);
    });
  }

  Future<void> _getCategories() async {
    _listCategoriesMap = [];
    var result = await _categoryRepository.select();
    for (var i = 0; i < result.length; i++) {
      _listCategoriesMap.add(result[i].toMap());
    }
    categoriesSink.add(_listCategoriesMap.reversed.toList());
  }

  _deleteCategory(String id) async {
    await _categoryRepository.delete(id);
    await _transactionCategoryRepository.delete(id);
    getCategoriesEventSink.add(null);
  }

  _getTransactions(String id) async {
    _listTransactionsMap = [];
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
      {
        "transactions": _listTransactionsMap.reversed.toList(),
        "totals": _categoryTotalsMap
      },
    );
  }

  @override
  void dispose() {
    _categoriesController.close();
    _transactionsController.close();
    _getCategoriesEventController.close();
    _getTransactionsEventController.close();
    _deleteCategoryEventController.close();
  }
}

CategoriesBloc categoriesBloc = CategoriesBloc();
