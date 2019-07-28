import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mpesa_ledger_flutter/models/summary_chart_model.dart';

class SummaryChart extends StatelessWidget {

  List<Map<String, dynamic>> monthlyTotals;

  SummaryChart(this.monthlyTotals);

  List<charts.Series<SummaryChartModel, String>> _generateChartData() {
    List<SummaryChartModel> depositData = [];
    List<SummaryChartModel> withdrawalData = [];
    for (var i = 0; i < monthlyTotals.length; i++) {
      depositData.add(SummaryChartModel(monthlyTotals[i]["month"], monthlyTotals[i]["deposits"], charts.Color.fromHex(code: "#66BB6A")));
      withdrawalData.add(SummaryChartModel(monthlyTotals[i]["month"], monthlyTotals[i]["withdrawals"], charts.Color.fromHex(code: "#EF5350")));
    }

    return [
      new charts.Series<SummaryChartModel, String>(
        id: 'Deposits',
        domainFn: (SummaryChartModel data, _) => data.month,
        measureFn: (SummaryChartModel data, _) => data.amount,
        colorFn: (SummaryChartModel data, _) => data.color,
        data: depositData,
      ),
      new charts.Series<SummaryChartModel, String>(
        id: 'Withdrawals',
        domainFn: (SummaryChartModel data, _) => data.month,
        measureFn: (SummaryChartModel data, _) => data.amount,
        colorFn: (SummaryChartModel data, _) => data.color,
        data: withdrawalData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _generateChartData(),
      animate: true,
      barGroupingType: charts.BarGroupingType.stacked
    );
  }
}