import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/blocs/settings/settings_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/intro/choose_theme.dart';
import 'package:mpesa_ledger_flutter/screens/settings/widgets/settings_header.dart';
import 'package:mpesa_ledger_flutter/screens/settings/widgets/settings_items.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/dialogs/alertDialog.dart';

class Settings extends StatefulWidget {
  SettingsBloc _settingsBloc = SettingsBloc();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _openChooseTheme(context) {
    prefix0.Navigator.push(context,
        MaterialPageRoute(builder: (route) => ChooseThemeWidget(false)));
  }

  _deleteAllData(context) {
    AlertDialogWidget(
      context,
      title: "Delete All Data?",
      content: prefix0.Text(
          "Are you sure you would like to delete all data ?, doing so will delete all data and close the app"),
      actions: [
        FlatButtonWidget(
          "CANCEL",
          () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
        FlatButtonWidget(
          "DELETE ALL DATA",
          () {
            widget._settingsBloc.deleteAllDataSink.add(null);
          },
        ),
      ],
    ).show();
  }

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
              SettingsItems("Delete All Data", () {
                _deleteAllData(context);
              })
            ],
          ),
        ),
      ],
    );
  }
}
