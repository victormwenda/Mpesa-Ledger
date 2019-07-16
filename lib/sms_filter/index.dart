import 'package:mpesa_ledger_flutter/sms_filter/sms_filters.dart';
import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class SMSFilter {
  static String body =
      "NFQ0UL54AK Confirmed. On 26/6/19 at 5:30 PM Give Ksh150.00 cash to Fontana Services Strathmore University Madaraka Olesangare RD New M-PESA balance is Ksh308.00. Dial *234*1# to manage your bills.";

  SMSFilters smsFilters = SMSFilters(body);

  bool isRegexTrue(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  void getSMSObject() async {
    smsFilters.getCoreValues();
  }

  void checkTypeOfSMS() {
    if (isRegexTrue(buyAirtimeForMyself)) {
      print("AIRTIME FOR MYSELF");
    } else if (isRegexTrue(buyAirtimeForSomeone)) {
      print("AIRTIME FOR SOMEONE");
    } else if (isRegexTrue(sendToPerson)) {
      print("SEND TO PERSON");
    } else if (isRegexTrue(receiveFromPerson)) {
      print("RECEIVE FROM PERSON");
    } else if (isRegexTrue(sendToPaybill)) {
      print("SEND TO PAYBILL");
    } else if (isRegexTrue(receiveFromPaybill)) {
      print("RECEIVE FROM PAYBILL");
    } else if (isRegexTrue(sendToBuyGoods)) {
      print("SEND TO BUY GOODS");
    } else if (isRegexTrue(sendToAgent)) {
      print("SEND TO AGENT");
    } else if (isRegexTrue(receiveFromAgent)) {
      print("RECEIVE FROM AGENT");
    } else if (isRegexTrue(reversalToAccount)) {
      print("REVERSAL TO ACCOUNT");
    } else if (isRegexTrue(receiveFromAgent)) {
      print("REVERSAL FROM ACCOUNT");
    } else {
      print("UNKNOWN SMS MESSAGE");
    }
  }
}
