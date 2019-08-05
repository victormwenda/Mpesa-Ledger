class UnrecordedTransactionsModel {
  int id;
  int timestamp;
  String body;

  UnrecordedTransactionsModel.fromMap(Map<String, dynamic> map) {
    timestamp = map["timestamp"] ?? null;
    body = map["body"] ?? null;
    id = map["id"] ?? null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["timestamp"] = timestamp;
    map["body"] = body;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
