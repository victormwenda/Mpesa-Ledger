import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/screens/intro/splash_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
