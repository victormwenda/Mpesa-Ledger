import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/routes/routes.dart';

class MainCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: RouteGeneratorCategory.generateRoute,
      initialRoute: "/",
    );
  }
}