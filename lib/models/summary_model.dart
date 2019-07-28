class SummaryModel {
  String id;
  String month;
  String monthInt;
  int year;
  double deposits;
  double withdrawals;
  double transactionCost;

  SummaryModel.fromMap(Map<String, dynamic> map) {
    month = map["month"] ?? null;
    monthInt = map["monthInt"] ?? null;
    year = map["year"] ?? null;
    deposits = map["deposits"] ?? null;
    withdrawals = map["withdrawals"] ?? null;
    transactionCost = map["transactionCost"] ?? null;
    id = year.toString() + "" + monthInt;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "month": month,
      "monthInt": monthInt,
      "year": year,
      "deposits": deposits,
      "withdrawals": withdrawals,
      "transactionCost": transactionCost,
      "id": id
    };
    return map;
  }
}
