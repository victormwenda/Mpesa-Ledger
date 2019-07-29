import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/screens/about/about.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/index.dart';
import 'package:mpesa_ledger_flutter/screens/category/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/settings/index.dart';
import 'package:mpesa_ledger_flutter/screens/summary/index.dart';
import 'package:mpesa_ledger_flutter/screens/transaction/index.dart';

class RouteGeneratorHome {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/transaction':
        return MaterialPageRoute(builder: (_) => Transaction(args));
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/about':
        return MaterialPageRoute(builder: (_) => About());
      default:
        print("error here " + settings.toString());
        return _errorRoute(settings.name);
    }
  }
}

class RouteGeneratorCalculator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Calculator());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/about':
        return MaterialPageRoute(builder: (_) => About());
      default:
        print("error here " + settings.toString());
        return _errorRoute(settings.name);
    }
  }
}

class RouteGeneratorSummary {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Summary());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/about':
        return MaterialPageRoute(builder: (_) => About());
      default:
        print("error here " + settings.toString());
        return _errorRoute(settings.name);
    }
  }
}

class RouteGeneratorCategory {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Category());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/about':
        return MaterialPageRoute(builder: (_) => About());
      default:
        print("error here " + settings.toString());
        return _errorRoute(settings.name);
    }
  }
}

Route<dynamic> _errorRoute(String name) {
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
