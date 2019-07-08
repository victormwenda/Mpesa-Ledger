import 'dart:async';

import 'package:flutter/services.dart';

class SplashScreenBloc {
  static const platform =
      const MethodChannel("com.example.mpesaLedgerFlutter/methodChannel");

  StreamController<void> _checkAndRequestPermissionController =
      StreamController<void>();
  Stream<void> get checkAndRequestPermissionStream =>
      _checkAndRequestPermissionController.stream;
  StreamSink<void> get checkAndRequestPermissionSink =>
      _checkAndRequestPermissionController.sink;

  StreamController<void> _continueToAppController =
      StreamController<void>();
  Stream<void> get continueToAppStream => _continueToAppController.stream;
  StreamSink<void> get continueToAppSink => _continueToAppController.sink;

  StreamController<bool> _permissionDenialController = StreamController<bool>();
  Stream<bool> get permissionDenialStream => _permissionDenialController.stream;
  StreamSink<bool> get permissionDenialSink => _permissionDenialController.sink;

  StreamController<bool> _openAppSettingsController = StreamController<bool>();
  Stream<bool> get openAppSettingsStream => _openAppSettingsController.stream;
  StreamSink<bool> get openAppSettingsSink => _openAppSettingsController.sink;

  SplashScreenBloc() {
    platform.setMethodCallHandler(_handleCallsFromNative);
    checkAndRequestPermissionStream.listen((void data) async {
      await platform.invokeMethod("isPermissionsAllowed");
    });
  }

  Future<void> _handleCallsFromNative(MethodCall call) async {
    switch (call.method) {
      case "showDialogForDenial":
        permissionDenialSink.add(true);
        break;
      case "showDialogForGoToSettings":
        openAppSettingsSink.add(true);
        break;
      case "continueToApp":
        continueToAppSink.add(null);
        break;
    }
  }

  void dispose() {
    _continueToAppController.close();
    _checkAndRequestPermissionController.close();
    _permissionDenialController.close();
    _openAppSettingsController.close();
  }
}
