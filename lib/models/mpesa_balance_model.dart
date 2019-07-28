class MpesaBalanceModel {
  int id;
  double mpesaBalance;

  MpesaBalanceModel.fromMap(Map<String, dynamic> map) {
    mpesaBalance = map["mpesaBalance"];
    id = map["id"] ?? 1;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "mpesaBalance": mpesaBalance,
      "id": id
    };
    return map;
  }
}
