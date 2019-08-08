import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/services/firebase/firebase_auth.dart';

class FirebaseAuthBloc extends BaseBloc {
  FirebaseAuthProvider _firebaseAuthProvider = FirebaseAuthProvider();

  // EVENTS

  StreamController<String> _signInEventController = StreamController<String>();
  Stream<String> get signInEventStream => _signInEventController.stream;
  StreamSink<String> get signInEventSink => _signInEventController.sink;

  StreamController<void> _signOutEventController = StreamController<void>();
  Stream<void> get signOutEventStream => _signOutEventController.stream;
  StreamSink<void> get signOutEventSink => _signOutEventController.sink;

  FirebaseAuthBloc() {
    signInEventStream.listen((void data) => _signIn());
    signOutEventStream.listen((void data) => _signOut());
  }

  void _signIn() {
    _firebaseAuthProvider.signIn();
  }

  void _signOut() {
    _firebaseAuthProvider.signOut();
  }

  @override
  void dispose() {
    _signInEventController.close();
    _signOutEventController.close();
  }
}
