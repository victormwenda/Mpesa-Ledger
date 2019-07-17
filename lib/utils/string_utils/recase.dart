import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';
import 'package:recase/recase.dart';

class ReCaseClass {
  String input;
  ReCase recase;

  ReCaseClass(this.input) {
    recase = ReCase(input);
  }

  String get title_case => recase.titleCase;

}