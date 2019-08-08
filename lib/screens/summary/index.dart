import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/summary/summary_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/summary/widgets/summary_totals.dart';
import 'package:mpesa_ledger_flutter/screens/summary/widgets/summary_year_monthly_totals.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Summary extends StatefulWidget {
  SummaryBloc _summaryBloc = SummaryBloc();

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  void initState() {
    widget._summaryBloc.getSummaryDataSink.add(null);
    super.initState();
  }

  @override
  void dispose() {
    widget._summaryBloc.dispose();
    super.dispose();
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
              Expanded(
                flex: 1,
                child: Text(
                  listMap[i]["month"],
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "+KES " + listMap[i]["deposits"].toString(),
                  style: Theme.of(context).textTheme.subtitle.merge(
                        TextStyle(
                          color: Color(0XFF4CAF50),
                        ),
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "-KES " + listMap[i]["withdrawals"].toString(),
                  style: Theme.of(context).textTheme.subtitle.merge(
                        TextStyle(
                          color: Color(0XFFF44336),
                        ),
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
            stream: widget._summaryBloc.transactionTotalsStream,
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> yearMonthlyTotalsList =
                    snapshot.data["yearMonthlyTotals"];
                return ListView.builder(
                  itemCount: yearMonthlyTotalsList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return SummaryTotals(snapshot.data["totals"]);
                    }
                    var year =
                        snapshot.data["yearMonthlyTotals"][index - 1]["year"];
                    var monthlyTotals = snapshot.data["yearMonthlyTotals"]
                        [index - 1]["monthlyTotals"];
                    return SummaryYearMonthlyTotals(
                      year,
                      monthlyTotals,
                      totalDeposits(monthlyTotals),
                      totalWithdrawals(monthlyTotals),
                      monthlyDepositsAnsWithdrawals(monthlyTotals),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
