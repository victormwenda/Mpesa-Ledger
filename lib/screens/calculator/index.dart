import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/calculator/calculator_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/widgets/calculator_textfield.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/widgets/transaction_charges_listview.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Calculator extends StatefulWidget {
  CalculatorBloc _calculatorBloc = CalculatorBloc();

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    widget._calculatorBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _amount.addListener(() {
      widget._calculatorBloc.transactionFeesEventSink.add(_amount.text);
    });

    return Column(
      children: <Widget>[
        AppbarWidget("Calculator", showSearch: false,),
        Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CalculatorTextFieldWidget(
                  _amount,
                ),
              ),
              Expanded(
                child: StreamBuilder<Map<String, String>>(
                  stream: widget._calculatorBloc.transactionFeesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TransactionChargesList(snapshot.data);
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
