import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  BottomNavigationBarWidget(this.navigatorKey);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  final routes = ["", "calculator", "summary", "category"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.navigatorKey.currentState.pushNamedAndRemoveUntil("/" + routes[index], (Route<dynamic> route) => false);
    });
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
          title: Text('Calculator'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('Summary'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
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
