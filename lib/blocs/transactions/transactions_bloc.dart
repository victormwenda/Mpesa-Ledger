import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';

class TransactionBloc extends BaseBloc{

  TransactionRepository transactionRepo = TransactionRepository();

  StreamController<List<TransactionModel>> transactionController = StreamController<List<TransactionModel>>();
  Stream<List<TransactionModel>> get transactionControllerStream => transactionController.stream;
  StreamSink<List<TransactionModel>> get transactionControllerSink => transactionController.sink;

  TransactionBloc() {
    getAllTransactions();
  }

  Future<void> getAllTransactions() async {
    transactionControllerSink.add(await transactionRepo.getAll());
  }

  @override
  void dispose() {
    transactionController.close();
  }
}