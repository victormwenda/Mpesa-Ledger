import 'package:mpesa_ledger_flutter/sms_filter/check_sms_type.dart';
import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class SMSFilter {
  Map<String, dynamic> smsObject = {};
  static String body =
      "TERT6566 confirmed. Reversal of transaction DFGFGDF546 has been successfully reversed on 12/12/19 at 12:45 pm and ksh600.00 is debited from your M-PESA account. New M-PESA account balance is ksh5000.00";

  CheckSMSType smsFilters = CheckSMSType(body);

  bool isRegexTrue(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  Map<String, dynamic> getSMSObject() {
    smsObject.addAll(smsFilters.getCoreValues());
    smsObject["data"].addAll(checkTypeOfSMS());
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
      result = {"error": "Unkwnown Transaction"};
    }
    return result;
  }
}
