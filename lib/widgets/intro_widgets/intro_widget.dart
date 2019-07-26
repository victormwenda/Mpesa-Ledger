import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_ledger_flutter/blocs/runtime_permissions/runtime_permission_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/intro/choose_theme.dart';
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
    widget.runtimePermissionBloc.checkAndRequestPermissionEventSink.add(null);
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
                widget.runtimePermissionBloc.checkAndRequestPermissionEventSink
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (route) => ChooseThemeWidget()),
      );
    });

    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.display2,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
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
                width: 20,
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FlatButtonWidget(
                "SKIP",
                () {
                  skip(context);
                },
                setColorToWhite: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
