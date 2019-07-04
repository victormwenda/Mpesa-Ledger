import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          centerTitle: true,
          title: Text("Calculator"),
        ),
        Expanded(
            child: Container(
          color: Colors.black,
        )),
      ],
    );
  }
}