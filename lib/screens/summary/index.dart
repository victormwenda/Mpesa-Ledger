import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/summary/summary_bloc.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/white_card.dart';

class Summary extends StatefulWidget {
  SummaryBloc summaryBloc = SummaryBloc();
  bool showHeader = true;
  Stream s;

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  void initState() {
    // widget.s = widget.summaryBloc.transactionTotalsStream;
    super.initState();
  }

  String totalDeposits(List<Map<String, dynamic>> listMap) {
    double totalDeposits = 0.0;
    for (var i = 0; i < listMap.length; i++) {
      totalDeposits += listMap[i]["deposits"];
    }
    return totalDeposits.toString();
  }

  String totalWithdrawals(List<Map<String, dynamic>> listMap) {
    double totalDeposits = 0.0;
    for (var i = 0; i < listMap.length; i++) {
      totalDeposits += listMap[i]["withdrawals"];
    }
    return totalDeposits.toString();
  }

  List<Widget> monthlyDepositsAnsWithdrawals(
      List<Map<String, dynamic>> listMap) {
    List<Widget> listWidget = [];
    for (var i = 0; i < listMap.length; i++) {
      listWidget.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                listMap[i]["month"],
                style: Theme.of(context).textTheme.subtitle,
              ),
              Text(
                "+KES " + listMap[i]["deposits"].toString(),
                style: Theme.of(context).textTheme.subtitle.merge(
                      TextStyle(
                        color: Color(0XFF4CAF50),
                      ),
                    ),
              ),
              Text(
                "-KES " + listMap[i]["withdrawals"].toString(),
                style: Theme.of(context).textTheme.subtitle.merge(
                      TextStyle(
                        color: Color(0XFFF44336),
                      ),
                    ),
              ),
            ],
          ),
        ),
      );
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Summary"),
        Expanded(
          child: StreamBuilder<Map<String, dynamic>>(
              stream: widget.summaryBloc.transactionTotalsStream,
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, dynamic>> yearMonthlyTotalsList =
                      snapshot.data["yearMonthlyTotals"];
                  return ListView.builder(
                    itemCount: yearMonthlyTotalsList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
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
                                    "+KES " +
                                        snapshot.data["totals"]["deposits"]
                                            .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .merge(
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
                                    "-KES " +
                                        snapshot.data["totals"]["withdrawals"]
                                            .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .merge(
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
                                      text: "-KES " +
                                          snapshot.data["totals"]
                                                  ["transactionCost"]
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .merge(
                                            TextStyle(
                                              color: Color(0XFFF44336),
                                            ),
                                          ),
                                      children: [
                                        TextSpan(
                                          text: "  in transaction costs",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
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
                      print(snapshot.data["yearMonthlyTotals"][index - 1]);
                      var year =
                          snapshot.data["yearMonthlyTotals"][index - 1]["year"];
                      var monthlyTotals = snapshot.data["yearMonthlyTotals"]
                          [index - 1]["monthlyTotals"];
                      return WhiteCardWidget(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                year.toString(),
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            Container(
                              child: Text("CHART HERE"),
                            ),
                            Container(
                              child: ExpansionTile(
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      "+KES " + totalDeposits(monthlyTotals),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle
                                          .merge(
                                            TextStyle(
                                              color: Color(0XFF4CAF50),
                                            ),
                                          ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "-KES " + totalWithdrawals(monthlyTotals),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle
                                          .merge(
                                            TextStyle(
                                              color: Color(0XFFF44336),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                                children: monthlyDepositsAnsWithdrawals(
                                    monthlyTotals),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ],
    );
  }
}
