import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("About", showSearch: false, showPopupMenuButton: false,),
        Expanded(
            child: Container(
        )),
      ],
    );
  }
}
