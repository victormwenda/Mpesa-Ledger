import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/generate_transactions.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';

class DailyTransactions extends StatelessWidget {
  Map<String, dynamic> transactions;

  DailyTransactions(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: CardWidget(
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      transactions["dateTime"]["dayInt"],
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions["dateTime"]["dayString"],
                          style: Theme.of(context).textTheme.caption.merge(
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Text(
                          transactions["dateTime"]["month"] +
                              " " +
                              transactions["dateTime"]["year"],
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: GenerateTransactions().generateTransactions(
                    context, transactions["transactions"], () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
