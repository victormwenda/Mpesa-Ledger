import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/calculator_textfield.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController amount = TextEditingController();

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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CalculatorTextFieldWidget(
                  amount,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transaction Fees",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
                      return ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Send to Person",
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
