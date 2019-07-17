import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart'
    as regexString;
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/recase.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/replace.dart';

class CheckSMSType {
  var replace = ReplaceClass();
  String body;

  CheckSMSType(this.body);

  bool checkRegexHasMatch(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  String getRegexFirstMatch(String expression) {
    return RegexClass(expression, body).getFirstMatch;
  }

  List<String> getRegexAllMatches(String expression, String input) {
    return RegexClass(expression, input).getAllMatchResults;
  }

  Map<String, dynamic> getCoreValues() {
    // Triggers if SMS message is not of importance
    if (!(checkRegexHasMatch(regexString.mpesaBalance) ||
        checkRegexHasMatch(regexString.transactionCost) ||
        checkRegexHasMatch(regexString.transactionId))) {
      return {"error": "Not an important SMS message"};
    }
    double mpesaBalance = checkRegexHasMatch(regexString.mpesaBalance)
        ? double.parse(
            replace.replaceString(
              getRegexFirstMatch(regexString.mpesaBalance),
              ",",
              "",
            ),
          )
        : null;
    double transactionCost = checkRegexHasMatch(regexString.transactionCost)
        ? double.parse(
            replace.replaceString(
              getRegexFirstMatch(regexString.transactionCost),
              ",",
              "",
            ),
          )
        : 0.00;
    String date = checkRegexHasMatch(regexString.date)
        ? getRegexFirstMatch(regexString.date)
        : "7/16/19";
    String time = checkRegexHasMatch(regexString.time)
        ? getRegexFirstMatch(regexString.time)
        : "10:33 AM";
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
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.buyAirtimeForMyself),
      ",",
      "",
    ));
    return {"amount": amount, "title": "Airtime", "body": body, "isDeposit": 0};
  }

  Map<String, dynamic> buyAirtimeForSomeone() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.buyAirtimeForSomeone),
      ",",
      "",
    ));
    return {"amount": amount, "title": "Airtime", "body": body, "isDeposit": 0};
  }

  Map<String, dynamic> sendToPerson() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.sendToPerson),
      ",",
      "",
    ));
    String title = ReCaseClass(replace
            .replaceString(
              getRegexFirstMatch(regexString.sendToPersonName),
              "0",
              "",
            )
            .trim())
        .title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 0};
  }

  Map<String, dynamic> receiveFromPerson() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.receiveFromPerson),
      ",",
      "",
    ));
    String title = ReCaseClass(replace
            .replaceString(
              getRegexFirstMatch(regexString.receiveFromPersonName),
              "0",
              "",
            )
            .trim())
        .title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 1};
  }

  Map<String, dynamic> sendToPaybill() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.sendToPaybill),
      ",",
      "",
    ));
    String title = ReCaseClass(
            getRegexFirstMatch(regexString.sendToPaybillBusinessName).trim())
        .title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 0};
  }

  Map<String, dynamic> receiveFromPaybill() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.receiveFromPaybill),
      ",",
      "",
    ));
    String title = ReCaseClass(
            getRegexFirstMatch(regexString.receiveFromPaybillBusinessName)
                .trim())
        .title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 1};
  }

  Map<String, dynamic> sendToBuyGoods() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.sendToBuyGoods),
      ",",
      "",
    ));
    String title = ReCaseClass(
            getRegexFirstMatch(regexString.sendToBuyGoodsBusinessName).trim())
        .title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 0};
  }

  Map<String, dynamic> depositToAgent() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.depositToAgent),
      ",",
      "",
    ));
    String title = ReCaseClass(getRegexFirstMatch(regexString.depositToAgentBusinessName).trim()).title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 1};
  }

  Map<String, dynamic> withdrawFromAgent() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.withdrawFromAgent),
      ",",
      "",
    ));
    String title = ReCaseClass(getRegexFirstMatch(regexString.withdrawFromAgentBusinessName).trim()).title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 0};
  }

  Map<String, dynamic> reversalToAccount() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.reversalToAccount),
      ",",
      "",
    ));
    return {
      "amount": amount,
      "title": "Reversal",
      "body": body,
      "isDeposit": 1
    };
  }

  Map<String, dynamic> reversalFromAccount() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.reversalFromAccount),
      ",",
      "",
    ));
    return {
      "amount": amount,
      "title": "Reversal",
      "body": body,
      "isDeposit": 0
    };
  }

  Map<String, dynamic> unknownSMSMessage() {
    String replaceCoreValues = replace.replaceString(
      replace.replaceString(body, regexString.mpesaBalance, ""),
      regexString.transactionCost,
      "",
    );
    String replaceCommas = replace.replaceString(replaceCoreValues, ",", "");
    List<double> amounts = getRegexAllMatches(regexString.amount, replaceCommas)
        .map(double.parse)
        .toList();
    return {
      "amounts": amounts,
      "body": body,
    };
  }
}
