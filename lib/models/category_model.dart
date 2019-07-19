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
    title = map["title"];
    description = map["description"];
    keywords = RegexUtil("\\w+", map["keywords"]).getAllMatchResults;
    showKeywords = map["showKeywords"] == 1 ? true : false;
    canDelete = map["canDelete"] == 1 ? true : false;
    numberOfTransactions = map["numberOfTransactions"];
    createdOn = map["createdOn"];
    id = map["id"] != null ? map["id"] : null;
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