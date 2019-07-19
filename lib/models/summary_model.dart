class SummaryModel {
  int id;
  String month;
  int year;
  double deposits;
  double withdrawals;
  double transactionCost;

  SummaryModel.fromMap(Map<String, dynamic> map) {
    month = map["month"];
    year = map["year"];
    deposits = map["deposits"];
    withdrawals = map["withdrawals"];
    transactionCost = map["transactionCost"];
    id = map["id"] != null ? map["id"] : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "month": month,
      "year": year,
      "deposits": deposits,
      "withdrawals": withdrawals,
      "transactionCost":transactionCost
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

}