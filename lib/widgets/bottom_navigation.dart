import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/index.dart';
import 'package:mpesa_ledger_flutter/screens/category/index.dart';
import 'package:mpesa_ledger_flutter/screens/home/index.dart';
import 'package:mpesa_ledger_flutter/screens/summary/index.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  BottomNavigationBarWidget(this.navigatorKey);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  List routes = [Home(), Calculator(), Summary(), Category()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      push(MaterialPageRoute(builder: (context) => routes[index]));
      print(_selectedIndex);
    });
  }

  Future<void> push(Route route) {
    return widget.navigatorKey.currentState.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Calucator'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Summary'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Category'),
        ),
      ],
      currentIndex: _selectedIndex,
      showUnselectedLabels: true,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }
}
