import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/replace.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';

class Transaction extends StatelessWidget {
  final Map<String, dynamic> transaction;

  Transaction(this.transaction);
  final ReplaceUtil replaceUtil = ReplaceUtil();

  _generateCatogories(List<String> listString) {
    List<Widget> chipLists = [];
    for (var i = 0; i < listString.length; i++) {
      chipLists.add(ChipWidget(listString[i]));
      chipLists.add(SizedBox(width: 7));
    }
    return chipLists;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppbarWidget(
          "Transaction",
          showSearch: false,
          showPopupMenuButton: false,
          showBackButton: true,
        ),
        Expanded(
          child: SingleChildScrollView(
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
                        color: transaction["isDeposit"]
                            ? Color(0XFF4CAF50)
                            : Color(0XFFF44336))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: _generateCatogories(transaction["categories"]),
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
                          text: transaction["jiffy"].yMMMEdjm,
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
                          text: "-KES " +
                              transaction["transactionCost"].toString(),
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
                          .merge(TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    ),
                    color: Theme.of(context).accentColor,
                    margin: 0,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
