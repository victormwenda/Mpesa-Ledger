import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/repository/transaction_repository.dart';

class TransactionBloc extends BaseBloc{

  TransactionRepository transactionRepo = TransactionRepository();

  StreamController<List<TransactionModel>> _transactionController = StreamController<List<TransactionModel>>();
  Stream<List<TransactionModel>> get transactionControllerStream => _transactionController.stream;
  StreamSink<List<TransactionModel>> get transactionControllerSink => _transactionController.sink;

  TransactionBloc() {
    _getAllTransactions();
  }

  Future<void> _getAllTransactions() async {
    transactionControllerSink.add(await transactionRepo.select());
  }

  @override
  void dispose() {
    _transactionController.close();
  }
}