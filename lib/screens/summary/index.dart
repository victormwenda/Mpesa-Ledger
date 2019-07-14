import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Summary"),
        Expanded(
            child: Container(
        )),
      ],
    );
  }
}