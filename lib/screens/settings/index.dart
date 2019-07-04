import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Settings"),
        Expanded(
            child: Container(
        )),
      ],
    );
  }
}
