import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/bottombar_navigation/bottombar_nav_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/unrecorded_transaction_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/main_home.dart';
import 'package:mpesa_ledger_flutter/screens/intro/splash_screen.dart';
import 'package:mpesa_ledger_flutter/services/firebase/firebase_auth.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation_bar/bottom_navigation.dart';

class App extends StatefulWidget {
  FirebaseAuthProvider _firebaseAuthProvider = FirebaseAuthProvider();
  BottombarNavigationBloc _bottombarNavigationBloc = BottombarNavigationBloc();
  UnrecordedTransactionsBloc _unrecordedTransactionsBloc =
      UnrecordedTransactionsBloc();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      widget._unrecordedTransactionsBloc.insertTransactionsEventSink.add(null);
    });
    widget._firebaseAuthProvider.onAuthStateChanged.listen((data) {
      if (data == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (route) => SplashScreen()),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget._unrecordedTransactionsBloc.dispose();
    widget._bottombarNavigationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: MainHome(),
        stream: widget._bottombarNavigationBloc.screensControllerStream,
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          return snapshot.data;
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).primaryColor),
        child: BottomNavigationBarWidget(widget._bottombarNavigationBloc),
      ),
    );
  }
}
