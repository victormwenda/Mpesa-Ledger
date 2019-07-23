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

  // EVENTS

  StreamController<void> _getSharedPreferencesEventController =
      StreamController<void>();
  Stream<void> get getSharedPreferencesEventStream =>
      _getSharedPreferencesEventController.stream;
  StreamSink<void> get getSharedPreferencesEventSink =>
      _getSharedPreferencesEventController.sink;

  StreamController<SharedPreferencesModel>
      _changeSharedPreferencesEventController =
      StreamController<SharedPreferencesModel>();
  Stream<SharedPreferencesModel> get changeSharedPreferencesEventStream =>
      _changeSharedPreferencesEventController.stream;
  StreamSink<SharedPreferencesModel> get changeSharedPreferencesEventSink =>
      _changeSharedPreferencesEventController.sink;

  SharedPreferencesBloc() {
    changeSharedPreferencesEventStream.listen((data) {
      _setSharedPreferences(data);
    });
    getSharedPreferencesEventStream.listen((void data) {
      _getSharedPreferences();
    });
  }

  Future<SharedPreferences> get sharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  Future<void> _getSharedPreferences() async {
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
    _changeSharedPreferencesEventController.close();
    _getSharedPreferencesEventController.close();
  }
}

SharedPreferencesBloc sharedPreferencesBloc = SharedPreferencesBloc();
