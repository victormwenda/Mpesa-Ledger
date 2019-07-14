import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/bottombarnavigation/bloc.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  var bloc = BottombarNavigationBloc();

  BottomNavigationBarWidget(this.bloc);

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
      currentIndex: _selectedIndex,
      showUnselectedLabels: true,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.black,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.bloc.showScreen(Screens.values[index]);
      },
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
