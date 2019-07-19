class ReplaceUtil {

  String replaceString(String input, String replaceWhat, String replaceWith) {
    return input.replaceAllMapped(RegExp(replaceWhat), (Match match) {
      return replaceWith;
    });
  }
}