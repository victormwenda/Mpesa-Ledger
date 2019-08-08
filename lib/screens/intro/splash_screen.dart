import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:mpesa_ledger_flutter/app.dart';
import 'package:mpesa_ledger_flutter/blocs/firebase/firebase_auth_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/runtime_permissions/runtime_permission_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/shared_preferences/shared_preferences_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/intro/choose_theme.dart';
import 'package:mpesa_ledger_flutter/services/firebase/firebase_auth.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/dialogs/alertDialog.dart';

class SplashScreen extends StatefulWidget {
  final FirebaseAuthBloc _firebaseAuthBloc = FirebaseAuthBloc();
  final FirebaseAuthProvider _onAuthStateChanged = FirebaseAuthProvider();
  final SharedPreferencesBloc _sharedPrefBloc = SharedPreferencesBloc();
  RuntimePermissionsBloc _runtimePermissionBloc = RuntimePermissionsBloc();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget._runtimePermissionBloc.dispose();
    widget._sharedPrefBloc.dispose();
    widget._firebaseAuthBloc.dispose();
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
              "To use MPESA LEDGER, allow SMS permissions are needed, please go to settings > Permissions and turn or SMS"),
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
          MaterialPageRoute(builder: (route) => App()),
        );
      } else {
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
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("MPESA", style: Theme.of(context).textTheme.display3),
                Text("Ledger", style: Theme.of(context).textTheme.headline),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              child: StreamBuilder(
                stream: widget._onAuthStateChanged.onAuthStateChanged,
                builder: (BuildContext context,
                    AsyncSnapshot<FirebaseUser> snapshot) {
                  if (snapshot.data == null) {
                    return GoogleSignInButton(
                      onPressed: () {
                        widget._firebaseAuthBloc.signInEventSink.add(null);
                      },
                    );
                  } else {
                    widget._runtimePermissionBloc
                        .checkAndRequestPermissionEventSink
                        .add(null);
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
