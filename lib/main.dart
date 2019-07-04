import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => Home(),
              ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(navigatorKey),
      ),
    );
  }
}
