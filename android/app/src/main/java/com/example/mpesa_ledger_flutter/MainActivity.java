package com.example.mpesa_ledger_flutter;

import android.Manifest;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  String CHANNEL = "com.example.mpesaLedgerFlutter/methodChannel";
  String[] appPermissions = {Manifest.permission.READ_SMS, Manifest.permission.RECEIVE_SMS};
  private static final int SMS_PERMISSION_REQUEST_CODE = 1;
  MethodChannel methodChannel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    methodChannel = new MethodChannel(getFlutterView(), CHANNEL);
    setMethodCallHandler();
  }

//  METHOD CHANNEL HANDLERS

  void setMethodCallHandler(){
    methodChannel.setMethodCallHandler((methodCall, result) -> {
      if (methodCall.method.equals("isPermissionsAllowed")) {
        checkAndRequestForPermissions();
        result.success(null);
      } else if (methodCall.method.equals("retrieveSMSMessages")) {
        Cursor cursor = getContentResolver().query(Uri.parse("content://sms/inbox"), null, null, null, null);
        SMSRetriever smsRetriever = new SMSRetriever(cursor);
        List<Map<String, Object>> smsResult = smsRetriever.getAllSMSMessages();
        result.success(smsResult);
      }
    });
  }

  void invokeMethod(String s, Object o) {
    methodChannel.invokeMethod(s, o);
  }


//  REQUEST RUNTIME PERMISSIONS

  void requestForPermissions(String[] permissions) {
    ActivityCompat.requestPermissions(this, permissions, SMS_PERMISSION_REQUEST_CODE);
  }

  void checkAndRequestForPermissions() {
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
      List<String> neededPermissions = new ArrayList<>();
      for (String perm: appPermissions) {
        if (ContextCompat.checkSelfPermission(this, perm) != PackageManager.PERMISSION_GRANTED) {
          neededPermissions.add(perm);
        }
      }

      if (!neededPermissions.isEmpty()) {
        requestForPermissions(neededPermissions.toArray(new String[0]));
      } else {
        continueToApp();
      }
    } else  {
      continueToApp();
    }
  }

  void continueToApp() {
    invokeMethod("continueToApp", null);
  }

  void showDialogForDenial() {
    invokeMethod("showDialogForDenial", null);
  }

  void showDialogForGoToSettings() {
    invokeMethod("showDialogForGoToSettings", null);
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    if (requestCode == SMS_PERMISSION_REQUEST_CODE) {
      List<Integer> deniedPermission = new ArrayList<>();
      int deniedCount = 0;
      for (int i = 0; i < grantResults.length; i++){
        if (grantResults[i]  == PackageManager.PERMISSION_DENIED) {
          deniedPermission.add(i);
          deniedCount++;
        }
      }

      if (deniedCount == 0) {
        continueToApp();
      } else {
        int result = 0;
        for (int i = 0; i < deniedPermission.size(); i++) {
          if (ActivityCompat.shouldShowRequestPermissionRationale(this, appPermissions[deniedPermission.get(i)])) {
            result =+ 0;
          }else {
            result =- 1;
          }
        }

        if (result == 0) {
          showDialogForDenial();
        }else {
          showDialogForGoToSettings();
        }
      }
    }
  }
}
