import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/shared_preferences_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBloc extends BaseBloc {
  StreamController<SharedPreferencesModel> _sharedPreferencesController =
      StreamController<SharedPreferencesModel>.broadcast();
  Stream<SharedPreferencesModel> get sharedPreferencesStream =>
      _sharedPreferencesController.stream;
  StreamSink<SharedPreferencesModel> get sharedPreferencesSink =>
      _sharedPreferencesController.sink;

  StreamController<SharedPreferencesModel> _changeSharedPreferencesController =
      StreamController<SharedPreferencesModel>();
  Stream<SharedPreferencesModel> get changeSharedPreferencesStream =>
      _changeSharedPreferencesController.stream;
  StreamSink<SharedPreferencesModel> get changeSharedPreferencesSink =>
      _changeSharedPreferencesController.sink;

  SharedPreferencesBloc() {
    changeSharedPreferencesStream.listen((data) {
      _setSharedPreferences(data);
    });
  }

  Future<SharedPreferences> get sharedPreferences async {
    return await SharedPreferences.getInstance();
  }
  
  Future<void> getSharedPreferences() async {
    var pref = await sharedPreferences;
    Map<String, dynamic> map = {
      "isDBCreated": pref.getBool("isDBCreated") ?? false,
    };
    sharedPreferencesSink.add(SharedPreferencesModel.fromMap(map));
  }

  Future<void> _setSharedPreferences(SharedPreferencesModel model) async {
    var pref = await sharedPreferences;
    if (model.isDBCreated != null) {
      pref.setBool("isDBCreated", model.isDBCreated);
    }
  }

  @override
  void dispose() {
    _sharedPreferencesController.close();
    _changeSharedPreferencesController.close();
  }
}

SharedPreferencesBloc sharedPreferencesBloc = SharedPreferencesBloc();
