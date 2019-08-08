import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/firebase/firebase_auth_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/models/shared_preferences_model.dart';

class SettingsBloc extends BaseBloc {

  SharedPreferencesBloc _sharedPreferencesBloc = SharedPreferencesBloc();
  FirebaseAuthBloc _firebaseAuthBloc = FirebaseAuthBloc();

  StreamController _deleteAllDataController = StreamController();
  Stream get deleteAllDataStream => _deleteAllDataController.stream;
  StreamSink get deleteAllDataSink => _deleteAllDataController.sink;

  SettingsBloc() {
    deleteAllDataStream.listen((void data) async {
      await databaseProvider.deleteDB();
      _sharedPreferencesBloc.changeSharedPreferencesEventSink.add(SharedPreferencesModel.fromMap({
        "isDBCreated": false
      }));
      _firebaseAuthBloc.signOutEventSink.add(null);
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    });
  }

  @override
  void dispose() {
    _deleteAllDataController.close();
  }
}
