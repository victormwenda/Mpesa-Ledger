class TransactionModel {
  int id;
  String title;
  String body;
  int timestamp;
  double mpesaBalance;
  double amount;
  bool isDeposit;
  double transactionCost;
  String transactionId;

  TransactionModel(
      {this.id,
      this.title,
      this.body,
      this.timestamp,
      this.mpesaBalance,
      this.amount,
      this.isDeposit,
      this.transactionCost,
      this.transactionId});

  TransactionModel.fromMap(Map<String, dynamic> map) {
    title = map["title"];
    body = map["body"];
    timestamp = map["timestamp"];
    mpesaBalance = map["mpesaBalance"];
    amount = map["amount"];
    isDeposit = map["isDeposit"] == 1 ? true : false;
    transactionCost = map["transactionCost"];
    transactionId = map["transactionId"];
    id = map["id"] ?? null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "body": body,
      "timestamp": timestamp,
      "mpesaBalance": mpesaBalance,
      "amount": amount,
      "isDeposit": isDeposit == true ? 1 : 0,
      "transactionCost": transactionCost,
      "transactionId": transactionId
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
