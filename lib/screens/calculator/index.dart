import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Calculator"),
        Expanded(
          child: Container(
          ),
        ),
      ],
    );
  }
}
