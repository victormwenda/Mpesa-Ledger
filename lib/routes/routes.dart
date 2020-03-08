import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/screens/calculator/index.dart';
import 'package:mpesa_ledger_flutter/screens/category/category_transaction.dart';
import 'package:mpesa_ledger_flutter/screens/category/create_category.dart';
import 'package:mpesa_ledger_flutter/screens/category/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/settings/index.dart';
import 'package:mpesa_ledger_flutter/screens/summary/index.dart';
import 'package:mpesa_ledger_flutter/screens/transaction/index.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/summary':
        return MaterialPageRoute(builder: (_) => Summary());
      case '/calculator':
        return MaterialPageRoute(builder: (_) => Calculator());
      case '/category':
        return MaterialPageRoute(builder: (_) => Category());
        case '/createCategory':
        return MaterialPageRoute(builder: (_) => CreateCategory());
      case '/categoryTransaction':
        return MaterialPageRoute(builder: (_) => CategoryTransaction(args));
      case '/transaction':
        return MaterialPageRoute(builder: (_) => Transaction(args));
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      default:
        return MaterialPageRoute(builder: (_) => Category());
    }
  }
}
