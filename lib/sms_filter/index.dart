import 'package:mpesa_ledger_flutter/sms_filter/check_sms_type.dart';
import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class SMSFilter {
  Map<String, dynamic> smsObject = {};
  static String body =
      "NFR5VCBFR9 Confirmed. On 27/6/19 at 5:21 PM Give Ksh100.00 cash to Camara (ss) Interco shariifs shoes shop six street eastleigh New M-PESA balance is Ksh293.00. Dial *234*1# to manage your bills.";

  CheckSMSType smsFilters = CheckSMSType(body);

  bool isRegexTrue(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  Map<String, dynamic> getSMSObject() {
    smsObject.addAll(smsFilters.getCoreValues());
    smsObject["data"].addAll(checkTypeOfSMS());
    print(smsObject);
    return smsObject;
  }

  Map<String, dynamic> checkTypeOfSMS() {
    Map<String, dynamic> result;
    if (isRegexTrue(buyAirtimeForMyself)) {
      result = smsFilters.buyAirtimeForMyself();
    } else if (isRegexTrue(buyAirtimeForSomeone)) {
      result = smsFilters.buyAirtimeForSomeone();
    } else if (isRegexTrue(depositToAgent)) {
      result = smsFilters.depositToAgent();
    } else if (isRegexTrue(withdrawFromAgent)) {
      result = smsFilters.withdrawFromAgent();
    } else if (isRegexTrue(sendToPerson)) {
      result = smsFilters.sendToPerson();
    } else if (isRegexTrue(receiveFromPerson)) {
      result = smsFilters.receiveFromPerson();
    } else if (isRegexTrue(sendToPaybill)) {
      result = smsFilters.sendToPaybill();
    } else if (isRegexTrue(receiveFromPaybill)) {
      result = smsFilters.receiveFromPaybill();
    } else if (isRegexTrue(sendToBuyGoods)) {
      result = smsFilters.sendToBuyGoods();
    } else if (isRegexTrue(reversalToAccount)) {
      result = smsFilters.reversalToAccount();
    } else if (isRegexTrue(reversalFromAccount)) {
      result = smsFilters.reversalFromAccount();
    } else {
      result = smsFilters.unknownSMSMessage();
    }
    return result;
  }
}
