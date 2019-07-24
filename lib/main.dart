import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/screens/intro/splash_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Color(0XFF000000),
          accentColor: Color(0XFFBDBDBD),
          cursorColor: Color(0XFFC2185B),
          focusColor: Colors.deepPurpleAccent[400],
          fontFamily: "Montserrat",
          textTheme: TextTheme(
            display3: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            headline: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
            subhead: TextStyle(fontSize: 15.0,),
            title: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            body1: TextStyle(),
            button: TextStyle(fontWeight: FontWeight.w800,),
          )
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
