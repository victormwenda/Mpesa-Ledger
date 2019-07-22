class MpesaBalanceModel {
  int id;
  double mpesaBalance;

  MpesaBalanceModel.fromMap(Map<String, dynamic> map) {
    mpesaBalance = map["mpesaBalance"];
    id = map["id"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "mpesaBalance": mpesaBalance,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
