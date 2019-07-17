import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart'
    as regexString;
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class CheckSMSType {
  String body;

  CheckSMSType(this.body);

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
    // Triggers if SMS message is not of importance
    if (!(checkRegexHasMatch(regexString.mpesaBalance) ||
        checkRegexHasMatch(regexString.tranactionCost) ||
        checkRegexHasMatch(regexString.transactionId))) {
      return {
        "error": "Not an important SMS message"
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
    return {
      "data": {
        "mpesaBalance": mpesaBalance,
        "timestamp": date + time,
        "transactionCost": transactionCost,
        "transactionId": transactionId
      },
    };
  }

  Map<String, dynamic> buyAirtimeForMyself() {
    double amount = double.parse(getRegexFirstMatch(regexString.buyAirtimeForMyself));
    return {
      "amount": amount,
      "title": "Airtime",
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> buyAirtimeForSomeone() {
    double amount = double.parse(getRegexFirstMatch(regexString.buyAirtimeForSomeone));
    return {
      "amount": amount,
      "title": "Airtime",
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> sendToPerson() {
    double amount = double.parse(getRegexFirstMatch(regexString.sendToPerson));
    String title = getRegexFirstMatch(regexString.sendToPersonName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> receiveFromPerson() {
    double amount = double.parse(getRegexFirstMatch(regexString.receiveFromPerson));
    String title = getRegexFirstMatch(regexString.receiveFromPersonName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 1
    };
  }

  Map<String, dynamic> sendToPaybill() {
    double amount = double.parse(getRegexFirstMatch(regexString.sendToPaybill));
    String title = getRegexFirstMatch(regexString.sendToPaybillBusinessName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> receiveFromPaybill() {
    double amount = double.parse(getRegexFirstMatch(regexString.receiveFromPaybill));
    String title = getRegexFirstMatch(regexString.receiveFromPaybillBusinessName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 1
    };
  }

  Map<String, dynamic> sendToBuyGoods() {
    double amount = double.parse(getRegexFirstMatch(regexString.sendToBuyGoods));
    String title = getRegexFirstMatch(regexString.sendToBuyGoodsBusinessName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> depositToAgent() {
    double amount = double.parse(getRegexFirstMatch(regexString.depositToAgent));
    String title = getRegexFirstMatch(regexString.depositToAgentBusinessName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 1
    };
  }

  Map<String, dynamic> withdrawFromAgent() {
    double amount = double.parse(getRegexFirstMatch(regexString.withdrawFromAgent));
    String title = getRegexFirstMatch(regexString.withdrawFromAgentBusinessName);
    return {
      "amount": amount,
      "title": title,
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> reversalToAccount() {
    double amount = double.parse(getRegexFirstMatch(regexString.reversalToAccount));
    return {
      "amount": amount,
      "title": "Reversal",
      "body": body,
      "isDeposit": 1
    };
  }

  Map<String, dynamic> reversalFromAccount() {
    double amount = double.parse(getRegexFirstMatch(regexString.reversalFromAccount));
    return {
      "amount": amount,
      "title": "Reversal",
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> unknownSMSMessage() {

  }
}
