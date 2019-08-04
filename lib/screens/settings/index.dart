import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/screens/intro/choose_theme.dart';
import 'package:mpesa_ledger_flutter/screens/settings/widgets/settings_header.dart';
import 'package:mpesa_ledger_flutter/screens/settings/widgets/settings_items.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

void _openChooseTheme(context) {
  prefix0.Navigator.push(context, MaterialPageRoute(builder: (route) => ChooseThemeWidget(false)));
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          "Settings",
          showSearch: false,
          showPopupMenuButton: false,
        ),
        Expanded(
          child: prefix0.ListView(
            children: <Widget>[
              SettingsHeader(),
              prefix0.SizedBox(
                height: 10,
              ),
              prefix0.Divider(
                color: prefix0.Colors.black45,
                indent: 20,
                endIndent: 20,
              ),
              SettingsItems("Change Theme", () {
                _openChooseTheme(context);
              }),
              SettingsItems("Delete All Data", () {})
            ],
          ),
        ),
      ],
    );
  }
}
