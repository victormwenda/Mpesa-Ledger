import 'package:mpesa_ledger_flutter/utils/date_format/date_format.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class CategoryModel {
  int id;
  String title;
  String description;
  List<String> keywords;
  bool showKeywords;
  bool canDelete;
  int numberOfTransactions;
  int createdOn;

  CategoryModel.fromMap(Map<String, dynamic> map) {
    title = map["title"] ?? null;
    description = map["description"] ?? null;
    keywords = map["keywords"] == null
        ? null
        : RegexUtil("[\\w-]+", map["keywords"]).getAllMatchResults;
    showKeywords = map["showKeywords"] == null
        ? true
        : map["showKeywords"] == 1 ? true : false;
    canDelete = map["canDelete"] == null 
        ? true 
        : map["canDelete"] == 1 ? true : false;
    numberOfTransactions = map["numberOfTransactions"] ?? 0;
    createdOn = map["createdOn"] ?? DateFormatUtil().getCurrentTimestamp;
    id = map["id"] ?? null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "description": description,
      "keywords": keywords.toString(),
      "showKeywords": showKeywords == true ? 1 : 0,
      "canDelete": canDelete == true ? 1 : 0,
      "numberOfTransactions": numberOfTransactions,
      "createdOn": createdOn
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
