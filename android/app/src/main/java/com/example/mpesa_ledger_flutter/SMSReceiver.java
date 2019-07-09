package com.example.mpesa_ledger_flutter;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.provider.Telephony;
import android.telephony.SmsMessage;
import android.widget.Toast;

public class SMSReceiver extends BroadcastReceiver {

  @Override
  public void onReceive(Context context, Intent intent) {
    if (Telephony.Sms.Intents.SMS_RECEIVED_ACTION.equals(intent.getAction())) {
      Toast.makeText(context, "Message received from SMS", Toast.LENGTH_SHORT).show();
      String smsSender = "";
      String smsBody = "";
      for (SmsMessage smsMessage : Telephony.Sms.Intents.getMessagesFromIntent(intent)) {
        smsBody += smsMessage.getMessageBody();
        smsSender += smsMessage.getOriginatingAddress();
      }
      Toast.makeText(context, smsBody + " : from : " + smsSender, Toast.LENGTH_SHORT).show();
    }
  }
}
