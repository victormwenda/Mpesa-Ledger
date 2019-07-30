import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';

class GenerateTransactions {
  _generateCatogories(List<String> listString) {
    List<Widget> chipLists = [];
    for (var i = 0; i < listString.length; i++) {
      chipLists.add(ChipWidget(listString[i]));
      chipLists.add(SizedBox(width: 7));
    }
    return chipLists;
  }

  List<Widget> generateTransactions(
      context, List<Map<String, dynamic>> listMap, Function closeSearch) {
    List<Widget> listWidget = [];
    for (var i = 0; i < listMap.length; i++) {
      var container = Container(
        child: InkWell(
          onTap: () {
            closeSearch();
            Navigator.pushNamed(context, "/transaction", arguments: listMap[i]);
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
}
