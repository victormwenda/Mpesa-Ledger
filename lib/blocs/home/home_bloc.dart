import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/repository/mpesa_balance_repository.dart';

class HomeBloc extends BaseBloc {
  MpesaBalanceRepository _mpesaBalanceRepository = MpesaBalanceRepository();

  StreamController<Map<String, dynamic>> _homeController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get homeStream => _homeController.stream;
  StreamSink<Map<String, dynamic>> get homeSink => _homeController.sink;

  HomeBloc() {
    _getHomeData();
  }

  Future<void> _getHomeData() async {
    Map<String, dynamic> map = {};
    map["headerData"] = {
      "mpesaBalance": await _getMpesaBalance()
    };
    print(map);
    homeSink.add(map);
  }

  Future<double> _getMpesaBalance() async {
    var result = await _mpesaBalanceRepository.select();
    return result.mpesaBalance;
  }

  @override
  void dispose() {}
}
