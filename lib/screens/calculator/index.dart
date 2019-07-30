import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/calculator/calculator_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/widgets/calculator_textfield.dart';
import 'package:mpesa_ledger_flutter/screens/calculator/widgets/transaction_charges_list.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Calculator extends StatefulWidget {
  CalculatorBloc calculatorBloc = CalculatorBloc();

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController amount = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    widget.calculatorBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    amount.addListener(() {
      widget.calculatorBloc.transactionFeesEventSink.add(amount.text);
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
                  amount,
                ),
              ),
              Expanded(
                child: StreamBuilder<Map<String, String>>(
                  stream: widget.calculatorBloc.transactionFeesStream,
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
