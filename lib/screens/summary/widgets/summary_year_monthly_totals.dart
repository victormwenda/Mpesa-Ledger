import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/summary/widgets/summary_chart.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/white_card.dart';

class SummaryYearMonthlyTotals extends StatelessWidget {
  int year;
  List<Map<String, dynamic>> monthlyTotals;
  String totalDeposits;
  String totalWithdrawals;
  List<Widget> monthlyDepositsAnsWithdrawals;

  SummaryYearMonthlyTotals(this.year, this.monthlyTotals, this.totalDeposits,
      this.totalWithdrawals, this.monthlyDepositsAnsWithdrawals);

  @override
  Widget build(BuildContext context) {
    return WhiteCardWidget(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                year.toString(),
                style: Theme.of(context).textTheme.headline.merge(TextStyle(
                  fontWeight: FontWeight.w700
                )),
              ),
            ),
          ),
          Container(
            child: SizedBox(
              height: 200.0,
              child: SummaryChart(monthlyTotals),
            ),
          ),
          Container(
            child: ExpansionTile(
              title: Row(
                children: <Widget>[
                  Text(
                    "+KES " + totalDeposits,
                    style: Theme.of(context).textTheme.subtitle.merge(
                          TextStyle(
                            color: Color(0XFF4CAF50),
                          ),
                        ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "-KES " + totalWithdrawals,
                    style: Theme.of(context).textTheme.subtitle.merge(
                          TextStyle(
                            color: Color(0XFFF44336),
                          ),
                        ),
                  ),
                ],
              ),
              children: monthlyDepositsAnsWithdrawals,
            ),
          ),
        ],
      ),
    );
  }
}
