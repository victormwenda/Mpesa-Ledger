import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart';
import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart'
    as regexString;
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class SMSFilters {
  String body;
  Map<String, dynamic> resultObject;

  SMSFilters(this.body);

  bool checkRegexHasMatch(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  String getRegexFirstMatch(String expression) {
    return RegexClass(expression, body).getFirstMatch;
  }

  List<String> getRegexAllMatches(String expression) {
    return RegexClass(expression, body).getAllMatchResults;
  }

  Map<String, dynamic> getCoreValues() {
    if (!(checkRegexHasMatch(regexString.mpesaBalance) ||
        checkRegexHasMatch(regexString.tranactionCost) ||
        checkRegexHasMatch(regexString.transactionId))) {
          print("NOT IMPOERTANT");
          return resultObject = {
            "rejected": "No an important MPESA SMS message"
          };
        }
    double mpesaBalance = checkRegexHasMatch(regexString.mpesaBalance)
        ? double.parse(getRegexFirstMatch(regexString.mpesaBalance))
        : null;
    String date = checkRegexHasMatch(regexString.date)
        ? getRegexFirstMatch(regexString.date)
        : "7/16/19";
    String time = checkRegexHasMatch(regexString.time)
        ? getRegexFirstMatch(regexString.time)
        : "10:33 AM";
    double transactionCost = checkRegexHasMatch(regexString.tranactionCost)
        ? double.parse(getRegexFirstMatch(regexString.tranactionCost))
        : 0.00;
    String transactionId = checkRegexHasMatch(regexString.transactionId)
        ? getRegexFirstMatch(regexString.transactionId)
        : null;
    resultObject = {
      "mpesaBalance": mpesaBalance,
      "date": date,
      "time": time,
      "transactionCost": transactionCost,
      "transactionId": transactionId
    };

    print(resultObject);

    return resultObject;
  }

  Map<String, dynamic> buyAirtimeForMyself() {}

  Map<String, dynamic> buyAirtimeForSomeone() {}

  Map<String, dynamic> sendToPerson() {}

  Map<String, dynamic> receiveFromPerson() {}

  Map<String, dynamic> sendToPaybill() {}

  Map<String, dynamic> receiveFromPaybill() {}

  Map<String, dynamic> sendToBuyGoods() {}

  Map<String, dynamic> sendToAgent() {}

  Map<String, dynamic> receiveFromAgent() {}

  Map<String, dynamic> reversalToAccount() {}

  Map<String, dynamic> reversalFromAccount() {}

  Map<String, dynamic> unknownSMSMessage() {}
}
