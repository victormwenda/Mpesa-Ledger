import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/index.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          centerTitle: true,
          title: Text("Home"),
        ),
        Expanded(
            child: Container(
          color: Colors.amber,
        )),
      ],
    );
  }
}
