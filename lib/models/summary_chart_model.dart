import 'package:charts_flutter/flutter.dart' as charts;

class SummaryChartModel {
  String month;
  double amount;
  charts.Color color;

  SummaryChartModel(this.month, this.amount, this.color);
}