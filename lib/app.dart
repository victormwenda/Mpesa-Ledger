import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/bottombarnavigation/bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/main_home.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation.dart';

class App extends StatelessWidget {
  final bloc = BottombarNavigationBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: MainHome(),
        stream: bloc.screensControllerStream,
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          return snapshot.data;
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(bloc),
    );
  }
}