import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_ledger_flutter/app.dart';
import 'package:app_settings/app_settings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const platform =
      const MethodChannel("com.example.mpesaLedgerFlutter/methodChannel");

  _SplashScreenState({Key key}) {
    platform.setMethodCallHandler(_handleCallsFromNative);
  }

  Future<void> _handleCallsFromNative(MethodCall call) {
    switch (call.method) {
      case "showDialogForDenial":
        showDialogForDenial();
        break;
      case "showDialogForGoToSettings":
        showDialogForGoToSettings();
        break;
    }
  }

  void checkAndRequestPermissions() async {
    await platform.invokeMethod("isPermissionsAllowed");
  }

  void continueToApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (route) => App()),
    );
  }

  void showDialogForDenial() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("SMS Permissions"),
          content: Text("To use MPESA LEDGER, allow SMS permissions"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
            FlatButton(
              child: Text("Allow Permissions"),
              onPressed: () {
                checkAndRequestPermissions();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void showDialogForGoToSettings() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("SMS Permissions"),
          content: Text(
              "To use MPESA LEDGER, allow SMS permissions are needed, please go to settings > Permissions and turn or SMS"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
            FlatButton(
              child: Text("Turn On"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
                AppSettings.openAppSettings();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    checkAndRequestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "TEST",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 45.0),
            ),
            Text(
              "TEST",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 45.0),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
