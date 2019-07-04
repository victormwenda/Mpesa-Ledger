import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          centerTitle: true,
          title: Text("Summary"),
        ),
        Expanded(
            child: Container(
          color: Colors.green,
        )),
      ],
    );
  }
}