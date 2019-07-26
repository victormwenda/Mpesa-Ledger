import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

class CalculatorBloc extends BaseBloc {
  StreamController<Map<String, String>> transactionFeesController =
      StreamController<Map<String, String>>();
  Stream<Map<String, String>> get transactionFeesStream => transactionFeesController.stream;
  StreamSink<Map<String, String>> get transactionFeesSink => transactionFeesController.sink;

  // EVENTS

  StreamController<String> transactionFeesEventController =
      StreamController<String>();
  Stream<String> get transactionFeesEventStream =>
      transactionFeesEventController.stream;
  StreamSink<String> get transactionFeesEventSink =>
      transactionFeesEventController.sink;

  CalculatorBloc() {
    transactionFeesEventStream.listen((String data) {
      transactionFeesSink.add(_calculateFees(data));
    });
  }

  Map<String, String> _calculateFees(String amountString) {
    Map<String, String> map = {
      "transferToMpesaUsers": "N/A",
      "transferToOtherUsers": "N/A",
      "transferToUnregisteredUsers": "N/A",
      "withdrawFromAgent": "N/A",
      "atmWithdrawal": "N/A"
    };
    if (amountString.isNotEmpty) {
      int amount = int.parse(amountString);
      if (amount >= 1 && amount <= 49) {
        map["transferToMpesaUsers"] = "FREE*";
        map["transferToOtherUsers"] = "N/A";
        map["transferToUnregisteredUsers"] = "N/A";
        map["withdrawFromAgent"] = "N/A";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 50 && amount <= 100) {
        map["transferToMpesaUsers"] = "FREE*";
        map["transferToOtherUsers"] = "N/A";
        map["transferToUnregisteredUsers"] = "N/A";
        map["withdrawFromAgent"] = "10";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 101 && amount <= 500) {
        map["transferToMpesaUsers"] = "11";
        map["transferToOtherUsers"] = "11";
        map["transferToUnregisteredUsers"] = "45";
        map["withdrawFromAgent"] = "27";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 501 && amount <= 1000) {
        map["transferToMpesaUsers"] = "15";
        map["transferToOtherUsers"] = "15";
        map["transferToUnregisteredUsers"] = "49";
        map["withdrawFromAgent"] = "28";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 1001 && amount <= 1500) {
        map["transferToMpesaUsers"] = "26";
        map["transferToOtherUsers"] = "26";
        map["transferToUnregisteredUsers"] = "59";
        map["withdrawFromAgent"] = "28";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 1501 && amount <= 2500) {
        map["transferToMpesaUsers"] = "41";
        map["transferToOtherUsers"] = "41";
        map["transferToUnregisteredUsers"] = "74";
        map["withdrawFromAgent"] = "28";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 2501 && amount <= 3500) {
        map["transferToMpesaUsers"] = "56";
        map["transferToOtherUsers"] = "56";
        map["transferToUnregisteredUsers"] = "112";
        map["withdrawFromAgent"] = "50";
        map["atmWithdrawal"] = "67";
      } else if (amount >= 3501 && amount <= 5000) {
        map["transferToMpesaUsers"] = "61";
        map["transferToOtherUsers"] = "61";
        map["transferToUnregisteredUsers"] = "135";
        map["withdrawFromAgent"] = "67";
        map["atmWithdrawal"] = "67";
      } else if (amount >= 5001 && amount <= 7500) {
        map["transferToMpesaUsers"] = "77";
        map["transferToOtherUsers"] = "77";
        map["transferToUnregisteredUsers"] = "166";
        map["withdrawFromAgent"] = "84";
        map["atmWithdrawal"] = "112";
      } else if (amount >= 7501 && amount <= 10000) {
        map["transferToMpesaUsers"] = "87";
        map["transferToOtherUsers"] = "87";
        map["transferToUnregisteredUsers"] = "205";
        map["withdrawFromAgent"] = "112";
        map["atmWithdrawal"] = "112";
      } else if (amount >= 10001 && amount <= 15000) {
        map["transferToMpesaUsers"] = "97";
        map["transferToOtherUsers"] = "197";
        map["transferToUnregisteredUsers"] = "265";
        map["withdrawFromAgent"] = "162";
        map["atmWithdrawal"] = "197";
      } else if (amount >= 15001 && amount <= 20000) {
        map["transferToMpesaUsers"] = "102";
        map["transferToOtherUsers"] = "102";
        map["transferToUnregisteredUsers"] = "288";
        map["withdrawFromAgent"] = "180";
        map["atmWithdrawal"] = "197";
      } else if (amount >= 20001 && amount <= 35000) {
        map["transferToMpesaUsers"] = "105";
        map["transferToOtherUsers"] = "105";
        map["transferToUnregisteredUsers"] = "309";
        map["withdrawFromAgent"] = "191";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 35001 && amount <= 50000) {
        map["transferToMpesaUsers"] = "105";
        map["transferToOtherUsers"] = "105";
        map["transferToUnregisteredUsers"] = "N/A";
        map["withdrawFromAgent"] = "270";
        map["atmWithdrawal"] = "N/A";
      } else if (amount >= 50001 && amount <= 70000) {
        map["transferToMpesaUsers"] = "105";
        map["transferToOtherUsers"] = "105";
        map["transferToUnregisteredUsers"] = "N/A";
        map["withdrawFromAgent"] = "300";
        map["atmWithdrawal"] = "N/A";
      } else {
        map["transferToMpesaUsers"] = "N/A";
        map["transferToOtherUsers"] = "N/A";
        map["transferToUnregisteredUsers"] = "N/A";
        map["withdrawFromAgent"] = "N/A";
        map["atmWithdrawal"] = "N/A";
      }
      if (amount >= 200 && amount <= 2500) {
        map["atmWithdrawal"] = "34";
      }
    }
    return map;
  }

  @override
  void dispose() {
    transactionFeesController.close();
  }
}
