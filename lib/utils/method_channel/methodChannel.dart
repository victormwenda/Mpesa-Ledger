import 'package:flutter/services.dart';

class MethodChannelClass {
  static const _platform =
      const MethodChannel("com.example.mpesaLedgerFlutter/methodChannel");
      
  Future<dynamic> invokeMethod(String method) async {
    return await _platform.invokeMethod(method);
  }

  void setMethodCallHandler(Future<void> handler(MethodCall call)) {
    _platform.setMethodCallHandler(handler);
  }
}
