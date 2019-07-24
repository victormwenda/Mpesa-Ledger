import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/bottombar_navigation/bottombar_nav_bloc.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottombarNavigationBloc bottombarNavigationBloc = BottombarNavigationBloc();

  BottomNavigationBarWidget(this.bottombarNavigationBloc);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

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
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: _selectedIndex,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white54,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.bottombarNavigationBloc.changeScreenEventSink
            .add(Screens.values[index]);
      },
    );
  }
}
