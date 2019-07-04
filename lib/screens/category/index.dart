import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Category"),
        Expanded(
            child: Container(
        )),
      ],
    );
  }
}