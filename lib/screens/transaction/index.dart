import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/replace.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';

class Transaction extends StatelessWidget {
  Map<String, dynamic> transaction;

  Transaction(this.transaction);
  ReplaceUtil replaceUtil = ReplaceUtil();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppbarWidget("Transaction"),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction["title"],
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  transaction["isDeposit"]
                      ? "+KES " + transaction["amount"].toString()
                      : "-KES " + transaction["amount"].toString(),
                  style: Theme.of(context).textTheme.title.merge(TextStyle(
                      fontSize: 16.5,
                      color: transaction["isDeposit"]
                          ? Color(0XFF4CAF50)
                          : Color(0XFFF44336))),
                ),
                SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: "Transaction ID:  ",
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      TextSpan(
                        text: transaction["transactionId"].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .merge(TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "Date and Time:  ",
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      TextSpan(
                        text: transaction["dateTime"].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .merge(TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "Transaction Cost:  ",
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      TextSpan(
                        text:
                            "-KES " + transaction["transactionCost"].toString(),
                        style: Theme.of(context).textTheme.body1.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFF44336))),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "MPESA Balance:  ",
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      TextSpan(
                        text: "KES " + transaction["mpesaBalance"].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .merge(TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Original Message",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 10,
                ),
                CardWidget(
                  Text(
                    replaceUtil.replaceString(
                        transaction["body"], "\\{.*\\}", ""),
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  color: Theme.of(context).accentColor,
                  margin: 0,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
