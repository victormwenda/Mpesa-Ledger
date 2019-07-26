import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/calculator/calculator_bloc.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/calculator_textfield.dart';

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
              Expanded(
                  child: StreamBuilder<Map<String, String>>(
                stream: widget.calculatorBloc.transactionFeesStream,
                // initialData: ,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Send to Mpesa User",
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    snapshot.data["transferToMpesaUsers"],
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Send to Other Mobile User",
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    snapshot.data["transferToOtherUsers"],
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Send to Unregistered Mpesa User",
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    snapshot
                                        .data["transferToUnregisteredUsers"],
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Withdraw From Agent",
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    snapshot.data["withdrawFromAgent"],
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Withdraw From ATM",
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    snapshot.data["atmWithdrawal"],
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ))
            ],
          ),
        ),
      ],
    );
  }
}
