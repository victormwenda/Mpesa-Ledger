import 'package:recase/recase.dart';

class RecaseUtil {
  String input;
  ReCase recase;

  RecaseUtil(this.input) {
    recase = ReCase(input);
  }

  String get title_case => recase.titleCase;
}
