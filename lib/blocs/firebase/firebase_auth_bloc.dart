import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/firebase/firebase_auth.dart';

class FirebaseAuthBloc extends BaseBloc {
  var _firebaseAuthProvider = FirebaseAuthProvider();

  StreamController<String> _signInController = StreamController<String>();
  Stream<String> get signInStream => _signInController.stream;
  StreamSink<String> get signInSink => _signInController.sink;

  StreamController<void> _signOutController = StreamController<void>();
  Stream<void> get signOutStream => _signOutController.stream;
  StreamSink<void> get signOutSink => _signOutController.sink;

  StreamController<FirebaseUser> _firebaseUserController =
      StreamController<FirebaseUser>.broadcast();
  Stream<FirebaseUser> get firebaseUserStream => _firebaseUserController.stream;
  StreamSink<void> get firebaseUserSink => _firebaseUserController.sink;

  FirebaseAuthBloc() {
    firebaseUserSink.add(null);
    signOutStream.listen((void data) => signOut());
    signInStream.listen((void data) => signIn());
  }

  Future<FirebaseUser> firebaseUser() async{
    return await _firebaseAuthProvider.firebaseUser;
  }

  void signIn() {
    _firebaseAuthProvider.signIn();
  }

  void signOut() {
    _firebaseAuthProvider.signOut();
  }

  @override
  void dispose() {
    _signInController.close();
    _signOutController.close();
    _firebaseUserController.close();
  }
}
