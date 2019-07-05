import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/app.dart';
import 'package:mpesa_ledger_flutter/screens/about/about.dart';

import 'package:mpesa_ledger_flutter/screens/calculator/index.dart';
import 'package:mpesa_ledger_flutter/screens/category/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/intro/splash_screen.dart';
import 'package:mpesa_ledger_flutter/screens/settings/index.dart';
import 'package:mpesa_ledger_flutter/screens/summary/index.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        print(settings);
        return MaterialPageRoute(builder: (_) => Home());
      case '/calculator':
        return MaterialPageRoute(builder: (_) => Calculator());
      case '/summary':
        return MaterialPageRoute(builder: (_) => Summary());
      case '/category':
        return MaterialPageRoute(builder: (_) => Category());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/about':
        return MaterialPageRoute(builder: (_) => About());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        print("error here "+settings.toString());
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String name) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR UNKWOWN ROUTE ' + name),
        ),
      );
    });
  }
}
