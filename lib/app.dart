import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/routes/routes.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation.dart';

class App extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute
        ),
        bottomNavigationBar: BottomNavigationBarWidget(navigatorKey),
      );
  }
}