import 'package:flutter/material.dart';

class CategoryTransactionHeader  extends StatelessWidget {

  Map<String, dynamic> totals;

  CategoryTransactionHeader(this.totals);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Total Deposits",
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "+KES " + totals["deposits"].toString(),
                style: Theme.of(context).textTheme.headline.merge(
                      TextStyle(
                        color: Color(0XFF4CAF50),
                      ),
                    ),
              ),
            ),
            Text(
              "Total Withdrawals",
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "-KES " + totals["withdrawals"].toString(),
                style: Theme.of(context).textTheme.headline.merge(
                      TextStyle(
                        color: Color(0XFFF44336),
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RichText(
                text: TextSpan(
                  text: "-KES " + totals["transactionCosts"].toString(),
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(
                          color: Color(0XFFF44336),
                        ),
                      ),
                  children: [
                    TextSpan(
                      text: "  in transaction costs",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}