class SummaryModel {
  String id;
  String month;
  int year;
  double deposits;
  double withdrawals;
  double transactionCost;

  SummaryModel.fromMap(Map<String, dynamic> map) {
    month = map["month"] == null ? null : map["month"];
    year = map["year"] == null ? null : map["year"];
    deposits = map["deposits"] == null ? null : map["deposits"];
    withdrawals = map["withdrawals"] == null ? null : map["withdrawals"];
    transactionCost =
        map["transactionCost"] == null ? null : map["transactionCost"];
    id = map["id"] == null ? null : map["id"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "month": month,
      "year": year,
      "deposits": deposits,
      "withdrawals": withdrawals,
      "transactionCost": transactionCost,
      "id": id
    };
    return map;
  }
}
