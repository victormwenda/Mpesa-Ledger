import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/bottombar_navigation/bottombar_nav_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/unrecorded_transaction_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/main_home.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation_bar/bottom_navigation.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';

class App extends StatefulWidget {
  BottombarNavigationBloc _bottombarNavigationBloc = BottombarNavigationBloc();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      unrecordedTransactionsBloc.insertTransactionsEventSink.add(null);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    unrecordedTransactionsBloc.dispose();
    widget._bottombarNavigationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Do you want to exit"),
            actions: <Widget>[
              FlatButtonWidget("No", () {
                Navigator.pop(context, false);
              }),
              FlatButtonWidget("Yes", () {
                Navigator.pop(context, true);
              }),
            ],
          );
        });
      },
      child: Scaffold(
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
      ),
    );
  }
}
