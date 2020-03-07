class RegexUtil {
  String expression;
  String input;
  String replaceWith;
  RegexUtil(this.expression, this.input);

  List<String> get getAllMatchResults {
    Iterable<RegExpMatch> matches = RegExp(expression).allMatches(input);
    List<RegExpMatch> listMatches = matches.toList();
    List<String> result = List<String>();
    for (var i = 0; i < listMatches.length; i++) {
      result.add(listMatches[i].group(0));
    }
    return result;
  }

  String get getFirstMatch {
    RegExpMatch match = RegExp(expression).firstMatch(input);
    return match?.group(0) != null ? match.group(0) : null;
  }

  bool get hasMatch {
    bool match = RegExp(expression).hasMatch(input);
    return match ? true : false;
  }
}