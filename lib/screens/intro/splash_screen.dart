import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mpesa_ledger_flutter/app.dart';
import 'package:mpesa_ledger_flutter/blocs/runtime_permissions/runtime_permission_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/intro/choose_theme.dart';
import 'package:mpesa_ledger_flutter/screens/intro/reteiveing_sms_screen.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/dialogs/alertDialog.dart';

class SplashScreen extends StatefulWidget {
  final SharedPreferencesBloc _sharedPrefBloc = SharedPreferencesBloc();
  RuntimePermissionsBloc _runtimePermissionBloc = RuntimePermissionsBloc();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void dispose() {
    widget._runtimePermissionBloc.dispose();
    widget._sharedPrefBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._runtimePermissionBloc.permissionDenialStream.listen((data) {
      if (data) {
        return AlertDialogWidget(
          context,
          title: "SMS Permission",
          content: Text("To use MPESA LEDGER, allow SMS permissions"),
          actions: <Widget>[
            FlatButtonWidget(
              "CANCEL",
              () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
            FlatButtonWidget(
              "ALLOW PERMISSIONS",
              () {
                widget._runtimePermissionBloc.checkAndRequestPermissionEventSink
                    .add(null);
                Navigator.pop(context);
              },
            )
          ],
        ).show();
      }
    });

    widget._runtimePermissionBloc.openAppSettingsStream.listen((data) {
      if (data) {
        return AlertDialogWidget(
          context,
          title: "SMS Permission",
          content: Text(
              "To use MPESA LEDGER, SMS permissions are needed, please go to settings > Permissions and turn on SMS"),
          actions: <Widget>[
            FlatButtonWidget(
              "CANCEL",
              () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
            FlatButtonWidget(
              "TURN ON",
              () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
                AppSettings.openAppSettings();
              },
            )
          ],
        ).show();
      }
    });

    widget._runtimePermissionBloc.continueToAppStream.listen((void v) {
      widget._sharedPrefBloc.getSharedPreferencesEventSink.add(null);
    });

    widget._sharedPrefBloc.sharedPreferencesStream.listen((data) {
      if (data.isDBCreated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (route) => RetreiveSMS()),
        );
      } else {
        // Where the intro will be placed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (route) => ChooseThemeWidget(true)),
        );
      }
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("MPESA", style: Theme.of(context).textTheme.display3),
                Text("Ledger", style: Theme.of(context).textTheme.headline),
              ],
            ),
          ),
          Expanded(
            child: RaisedButtonWidget("GET STARTED", () => {
              widget._runtimePermissionBloc
                  .checkAndRequestPermissionEventSink
                  .add(null)
            }),
          ),
        ],
      ),
    );
  }
}
