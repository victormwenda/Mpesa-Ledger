import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';

class TransactionBloc extends BaseBloc{
  StreamController<TransactionModel> insertTransactionController = StreamController<TransactionModel>();

  @override
  void dispose() {
    insertTransactionController.close();
  }
}