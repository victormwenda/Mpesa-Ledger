import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';

class DailyTransactions extends StatelessWidget {
  Map<String, dynamic> transactions;

  DailyTransactions(this.transactions);

  _generateCatogories(List<String> listString) {
    List<Widget> chipLists = [];
    for (var i = 0; i < listString.length; i++) {
      chipLists.add(ChipWidget(listString[i]));
      chipLists.add(SizedBox(width: 7));
    }
    return chipLists;
  }

  List<Widget> _generateTransactions(
      context, List<Map<String, dynamic>> listMap) {
    List<Widget> listWidget = [];
    for (var i = 0; i < listMap.length; i++) {
      var container = Container(
        child: InkWell(
          onTap: () {
            print(listMap[i]["title"]);
          },
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.black45,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        listMap[i]["title"],
                        style: Theme.of(context).textTheme.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      listMap[i]["isDeposit"]
                          ? "+KES " + listMap[i]["amount"].toString()
                          : "-KES " + listMap[i]["amount"].toString(),
                      style: Theme.of(context).textTheme.title.merge(TextStyle(
                          fontSize: 16.5,
                          color: listMap[i]["isDeposit"]
                              ? Color(0XFF4CAF50)
                              : Color(0XFFF44336))),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  listMap[i]["transactionId"],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  listMap[i]["time"],
                  style: Theme.of(context).textTheme.caption,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _generateCatogories(listMap[i]["categories"]),
                  ),
                )
              ],
            ),
          ),
        ),
      );
      listWidget.add(container);
    }
    return listWidget;
  }

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
                children: _generateTransactions(
                    context, transactions["transactions"]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
