class TransactionCategoryModel {
  int id;
  int transactionId;
  int categoryId;

  TransactionCategoryModel.fromMap(Map<String, dynamic> map) {
    transactionId = map["transactionId"];
    categoryId = map["categoryId"];
    id = map["id"] != null ? map["id"] : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "transactionId": transactionId,
      "categoryId": categoryId
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
