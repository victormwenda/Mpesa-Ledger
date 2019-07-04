import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Home"),
        Expanded(
            child: Container(
        )),
      ],
    );
  }
}
