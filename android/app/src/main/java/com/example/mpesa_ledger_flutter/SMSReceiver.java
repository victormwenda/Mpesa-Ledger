package com.example.mpesa_ledger_flutter;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.provider.Telephony;
import android.telephony.SmsMessage;
import android.util.Log;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SMSReceiver extends BroadcastReceiver {

  @Override
  public void onReceive(Context context, Intent intent) {
    if (Telephony.Sms.Intents.SMS_RECEIVED_ACTION.equals(intent.getAction())) {

      Toast.makeText(context, "Message received from SMS", Toast.LENGTH_SHORT).show();
      List<Map<String, String>> mapList = new ArrayList<>();
      for (SmsMessage smsMessage : Telephony.Sms.Intents.getMessagesFromIntent(intent)) {
        Map<String, String> map = new HashMap<>();
        map.put("address", smsMessage.getOriginatingAddress());
        if (smsMessage.getOriginatingAddress().equals("MPESA")) {
          map.put("body", smsMessage.getMessageBody());
          map.put("timestamp", String.valueOf(smsMessage.getTimestampMillis()));
          mapList.add(map);
        }
      }

      if (!mapList.isEmpty()) {
        DatabaseHelper databaseHelper = new DatabaseHelper(context);
        databaseHelper.insertUnrecordedTransactions(mapList);
      }

      Toast.makeText(context, mapList.toString(), Toast.LENGTH_SHORT).show();
    }
  }
}
