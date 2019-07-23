import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/repository/category_repository.dart';
import 'package:mpesa_ledger_flutter/utils/regex/regex.dart';

class CheckSMSCategory {
  String body;
  int id;
  List<CategoryModel> categoryObject;

  CategoryRepository categoryRepo = CategoryRepository();

  CheckSMSCategory(this.categoryObject, this.body, this.id);

  Future<List<Map<String, int>>> addCategeoryToTransaction() async {
    List<Map<String, int>> foundCategories = [];
    for (var i = 0; i < categoryObject.length; i++) {
      Map<String, int> transcationCategoryObject = {};
      var categoryKeywords = categoryObject[i].keywords;
      for (var j = 0; j < categoryKeywords.length; j++) {
        var result = RegexUtil(categoryKeywords[j].toLowerCase(), body.toLowerCase()).hasMatch;
        if (result) {
          transcationCategoryObject.addAll({
            "transactionId": id,
            "categoryId": categoryObject[i].id,
          });
          foundCategories.add(transcationCategoryObject);
        }
      }
    }
    return foundCategories;
  }
}
