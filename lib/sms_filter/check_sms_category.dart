import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/repository/category_repository.dart';

class CheckSMSCategory {
  String body;
  int id;

  CategoryRepository categoryRepo = CategoryRepository();

  CheckSMSCategory(this.body, this.id);

  Future<List<CategoryModel>> getAllCategories() async {
    return await categoryRepo.getAll(["id", "keywords"]);
  }

  addCategeoryToTransaction() async {
    var categoryModel = await getAllCategories();
    for (var i = 0; i < categoryModel.length; i++) {
      var categoryKeywords = categoryModel[i].keywords;
      for (var j = 0; j < categoryKeywords.length; j++) {
        
      }
    }
  }
}