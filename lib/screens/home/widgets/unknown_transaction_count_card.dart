import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';

class UnknownTransactionCount extends StatelessWidget {

  int unknownTransactionCount;

  UnknownTransactionCount(this.unknownTransactionCount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: CardWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              unknownTransactionCount.toString() + " unknown transactions were found",
              style: Theme.of(context).textTheme.subhead.merge(
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButtonWidget(
                  "VIEW",
                  () {},
                  setColorToWhite: true,
                ))
          ],
        ),
        color: Theme.of(context).primaryColor,
        padding: 15,
        margin: 0,
      ),
    );
  }
}
