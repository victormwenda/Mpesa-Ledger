import 'package:flutter/services.dart';

class MethodChannelClass {
  static const _platform =
      const MethodChannel("com.example.mpesaLedgerFlutter/methodChannel");
      
  Future<dynamic> invokeMethod(String method, {dynamic argument: ""}) async {
    return await _platform.invokeMethod(method, argument);
  }

  void setMethodCallHandler(Future<void> handler(MethodCall call)) {
    _platform.setMethodCallHandler(handler);
  }
}
