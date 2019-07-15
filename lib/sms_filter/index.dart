import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class SMSFilter {
  String body =
      "[TXNID] confirmed. Reversal of transaction [TXNID] has been successfully reversed on 14/12/19 at 12:30 PM and Ksh2999.00 is debited from your M-PESA account. New M-PESA account balance is [AMOUNT]";

  String t = "\\d{1,2}/\\d{1,2}/\\d{2,4}";

  void getRegex() {
    String t = reversalFromAccount;
    print(t);
    RegexClass regex = RegexClass(RegExp(t), body);
    print(regex.hasMatch);
      print(regex.getFirstMatch);
      print(regex.getAllMatchResults);
  }

  

  void checkTypeOfSMS() {
    if(RegexClass(RegExp(t), body).hasMatch) {

    }
  }
}
