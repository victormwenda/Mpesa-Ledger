import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mpesa_ledger_flutter/models/category_chart_model.dart';

class CategoryChart extends StatelessWidget {
  List<Map<String, dynamic>> categories;

  CategoryChart(this.categories);

  charts.Color _getChartColor(int colorValue) {
    if (colorValue == 0XFF000000) {
      return charts.Color.fromHex(code: "#BDBDBD");
    } else if (colorValue == 0XFFE91E63) {
      return charts.Color.fromHex(code: "#F06292");
    } else if (colorValue == 0XFF9C27B0) {
      return charts.Color.fromHex(code: "#BA68C8");
    } else if (colorValue == 0XFF2196F3) {
      return charts.Color.fromHex(code: "#64B5F6");
    } else {
      return charts.Color.fromHex(code: "#BDBDBD");
    }
  }

  List<charts.Series<CategoryChartModel, String>> _generateChartData(context) {
    List<CategoryChartModel> data = [];
    for (var i = 0; i < categories.length; i++) {
      data.add(CategoryChartModel(
          categories[i]["title"], categories[i]["numberOfTransactions"]));
    }

    return [
      new charts.Series<CategoryChartModel, String>(
        id: 'Categories',
        domainFn: (CategoryChartModel data, _) => data.title,
        measureFn: (CategoryChartModel data, _) => data.numOfTransaction,
        labelAccessorFn: (CategoryChartModel data, _) => "${data.title} (${data.numOfTransaction})",
        colorFn: (CategoryChartModel data, _) =>
            _getChartColor(Theme.of(context).primaryColor.value),
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: charts.PieChart(
        _generateChartData(context),
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside,
            )
          ],
        ),
      ),
    );
  }
}
