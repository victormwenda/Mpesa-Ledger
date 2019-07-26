import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/summary/summary_bloc.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Summary extends StatefulWidget {
  SummaryBloc summaryBloc = SummaryBloc();

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool showHeader = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Summary"),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              if (showHeader) {
                showHeader = false;
                return StreamBuilder<Map<String, double>>(
                  stream: widget.summaryBloc.transactionTotalsStream,
                  initialData: {
                    "deposits": 0.0,
                    "withdrawals": 0.0,
                    "transactionCost": 0.0,
                  },
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, double>> snapshot) {
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
                                "KES " + snapshot.data["deposits"].toString(),
                                style:
                                    Theme.of(context).textTheme.headline.merge(
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
                                "KES " +
                                    snapshot.data["withdrawals"].toString(),
                                style:
                                    Theme.of(context).textTheme.headline.merge(
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
                                  text: "KES " +
                                      snapshot.data["transactionCost"]
                                          .toString(),
                                  style:
                                      Theme.of(context).textTheme.title.merge(
                                            TextStyle(
                                              color: Color(0XFFF44336),
                                            ),
                                          ),
                                  children: [
                                    TextSpan(
                                      text: "  in transaction costs",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Text(index.toString());
            },
          ),
        ),
      ],
    );
  }
}
