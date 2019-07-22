import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_ledger_flutter/blocs/runtime_permissions/runtime_permission_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/intro/reteiveing_sms_screen.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/dialogs/alertDialog.dart';

class IntroWidget extends StatefulWidget {
  String title;
  String description;

  RuntimePermissionsBloc runtimePermissionBloc = RuntimePermissionsBloc();

  IntroWidget(this.title, this.description);

  @override
  _IntroWidgetState createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  skip(BuildContext context) {
    widget.runtimePermissionBloc.checkAndRequestPermissionSink.add(null);
  }

  @override
  Widget build(BuildContext context) {
    widget.runtimePermissionBloc.permissionDenialStream.listen((data) {
      if (data) {
        return AlertDialogWidget(
          context,
          title: "SMS Permission",
          content: Text("To use MPESA LEDGER, allow SMS permissions"),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
            FlatButton(
              child: Text("ALLOW PERMISSIONS"),
              onPressed: () {
                widget.runtimePermissionBloc.checkAndRequestPermissionSink
                    .add(null);
                Navigator.pop(context);
              },
            )
          ],
        ).show();
      }
    });

    widget.runtimePermissionBloc.openAppSettingsStream.listen((data) {
      if (data) {
        return AlertDialogWidget(
          context,
          title: "SMS Permission",
          content: Text(
              "To use MPESA LEDGER, allow SMS permissions are needed, please go to settings > Permissions and turn or SMS"),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
            FlatButton(
              child: Text("TURN ON"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
                AppSettings.openAppSettings();
              },
            )
          ],
        ).show();
      }
    });

    widget.runtimePermissionBloc.continueToAppStream.listen((void v) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (route) => RetreiveSMS()),
      );
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButtonWidget("SKIP", () {
                  skip(context);
                })),
          ),
        ],
      ),
    );
  }
}
