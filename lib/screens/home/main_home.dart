import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/routes/routes.dart';

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: "/",
    );
  }
}
