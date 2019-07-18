import 'package:mpesa_ledger_flutter/utils/constants/regex_constants.dart'
    as regexString;
import 'package:mpesa_ledger_flutter/utils/date_format/date_format.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/recase.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/replace.dart';

class CheckSMSType {
  var replace = ReplaceClass();
  var dateFormatUtil = DateFormatUtil();
  String body;
  String timestamp;

  CheckSMSType(this.body, this.timestamp);

  bool isRegexTrue(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  bool checkRegexHasMatch(String expression) {
    return RegexClass(expression, body).hasMatch;
  }

  String getRegexFirstMatch(String expression) {
    return RegexClass(expression, body).getFirstMatch;
  }

  List<String> getRegexAllMatches(String expression, String input) {
    return RegexClass(expression, input).getAllMatchResults;
  }

  Map<String, dynamic> checkTypeOfSMS() {
    Map<String, dynamic> result;
    if (isRegexTrue(regexString.buyAirtimeForMyself)) {
      result = buyAirtimeForMyself();
    } else if (isRegexTrue(regexString.buyAirtimeForSomeone)) {
      result = buyAirtimeForSomeone();
    } else if (isRegexTrue(regexString.depositToAgent)) {
      result = depositToAgent();
    } else if (isRegexTrue(regexString.withdrawFromAgent)) {
      result = withdrawFromAgent();
    } else if (isRegexTrue(regexString.sendToPerson)) {
      result = sendToPerson();
    } else if (isRegexTrue(regexString.receiveFromPerson)) {
      result = receiveFromPerson();
    } else if (isRegexTrue(regexString.sendToPaybill)) {
      result = sendToPaybill();
    } else if (isRegexTrue(regexString.receiveFromPaybill)) {
      result = receiveFromPaybill();
    } else if (isRegexTrue(regexString.sendToBuyGoods)) {
      result = sendToBuyGoods();
    } else if (isRegexTrue(regexString.reversalToAccount)) {
      result = reversalToAccount();
    } else if (isRegexTrue(regexString.reversalFromAccount)) {
      result = reversalFromAccount();
    } else {
      result = unknownSMSMessage();
    }
    return result;
  }

  Future<Map<String, dynamic>> getCoreValues() async {
    // Triggers if SMS message is not of importance
    if (!(checkRegexHasMatch(regexString.mpesaBalance) ||
        checkRegexHasMatch(regexString.transactionCost) ||
        checkRegexHasMatch(regexString.transactionId))) {
      return {
        "error": "Not an important SMS message"
      };
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
    int dateTime = checkRegexHasMatch(regexString.date) &&
            checkRegexHasMatch(regexString.time)
        ? await dateFormatUtil.getTimestamp(getRegexFirstMatch(regexString.date) +
            " " +
            getRegexFirstMatch(regexString.time))
        : int.parse(timestamp);
    String transactionId = checkRegexHasMatch(regexString.transactionId)
        ? getRegexFirstMatch(regexString.transactionId)
        : null;
    return {
      "data": {
        "mpesaBalance": mpesaBalance,
        "timestamp": dateTime,
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
    String title = ReCaseClass(
            getRegexFirstMatch(regexString.depositToAgentBusinessName).trim())
        .title_case;
    return {"amount": amount, "title": title, "body": body, "isDeposit": 1};
  }

  Map<String, dynamic> withdrawFromAgent() {
    double amount = double.parse(replace.replaceString(
      getRegexFirstMatch(regexString.withdrawFromAgent),
      ",",
      "",
    ));
    String title = ReCaseClass(
            getRegexFirstMatch(regexString.withdrawFromAgentBusinessName)
                .trim())
        .title_case;
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
