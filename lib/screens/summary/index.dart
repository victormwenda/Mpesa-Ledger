import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/summary/summary_bloc.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

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
                  return ListView.builder(
                    itemCount: 50,
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
                                    "KES " +
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
                                    "KES " +
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
                                      text: "KES " +
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
                      return Text(index.toString());
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ],
    );
  }
}

// return Container(
//                       alignment: Alignment.topLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               "Total Deposits",
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 8.0),
//                               child: Text(
//                                 "KES " + snapshot.data["deposits"].toString(),
//                                 style:
//                                     Theme.of(context).textTheme.headline.merge(
//                                           TextStyle(
//                                             color: Color(0XFF4CAF50),
//                                           ),
//                                         ),
//                               ),
//                             ),
//                             Text(
//                               "Total Withdrawals",
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 8.0),
//                               child: Text(
//                                 "KES " +
//                                     snapshot.data["withdrawals"].toString(),
//                                 style:
//                                     Theme.of(context).textTheme.headline.merge(
//                                           TextStyle(
//                                             color: Color(0XFFF44336),
//                                           ),
//                                         ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20.0),
//                               child: RichText(
//                                 text: TextSpan(
//                                   text: "KES " +
//                                       snapshot.data["transactionCost"]
//                                           .toString(),
//                                   style:
//                                       Theme.of(context).textTheme.title.merge(
//                                             TextStyle(
//                                               color: Color(0XFFF44336),
//                                             ),
//                                           ),
//                                   children: [
//                                     TextSpan(
//                                       text: "  in transaction costs",
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
