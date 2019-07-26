import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';

import 'package:mpesa_ledger_flutter/utils/method_channel/methodChannel.dart';

class RuntimePermissionsBloc extends BaseBloc {
  MethodChannelClass methodChannel = MethodChannelClass();

  StreamController<void> _continueToAppController = StreamController<void>.broadcast();
  Stream<void> get continueToAppStream => _continueToAppController.stream;
  StreamSink<void> get continueToAppSink => _continueToAppController.sink;

  StreamController<bool> _permissionDenialController =
      StreamController<bool>.broadcast();
  Stream<bool> get permissionDenialStream => _permissionDenialController.stream;
  StreamSink<bool> get permissionDenialSink => _permissionDenialController.sink;

  StreamController<bool> _openAppSettingsController = StreamController<bool>.broadcast();
  Stream<bool> get openAppSettingsStream => _openAppSettingsController.stream;
  StreamSink<bool> get openAppSettingsSink => _openAppSettingsController.sink;

  // EVENTS

  StreamController<void> _checkAndRequestPermissionEventController =
      StreamController<void>();
  Stream<void> get checkAndRequestPermissionEventStream =>
      _checkAndRequestPermissionEventController.stream;
  StreamSink<void> get checkAndRequestPermissionEventSink =>
      _checkAndRequestPermissionEventController.sink;

  RuntimePermissionsBloc() {
    methodChannel.setMethodCallHandler(_handleCallsFromNative);
    checkAndRequestPermissionEventStream.listen((void data) async {
      await methodChannel.invokeMethod("isPermissionsAllowed");
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

  @override
  void dispose() {
    _continueToAppController.close();
    _checkAndRequestPermissionEventController.close();
    _permissionDenialController.close();
    _openAppSettingsController.close();
  }
}
