import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/shared_preferences_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBloc extends BaseBloc {
  StreamController<SharedPreferencesModel> sharedPreferencesController =
      StreamController<SharedPreferencesModel>();
  Stream<SharedPreferencesModel> get sharePreferencesStream =>
      sharedPreferencesController.stream;
  StreamSink<SharedPreferencesModel> get sharePreferencesSink =>
      sharedPreferencesController.sink;

  Future<SharedPreferences> get sharedPreferences async {
    return await SharedPreferences.getInstance();
  }
  
  Future<void> getSharedPreferences() async {
    var pref = await sharedPreferences;

  }

  Future<void> setSharedPreferences() async {
    var pref = await sharedPreferences;
    
  }

  @override
  void dispose() {
    sharedPreferencesController.close();
  }
}

SharedPreferencesBloc sharedPreferencesBloc = SharedPreferencesBloc();
