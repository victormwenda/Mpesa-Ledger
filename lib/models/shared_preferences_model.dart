class SharedPreferencesModel {
  bool isDBCreated;
  Map<String, dynamic> themeMap;

  SharedPreferencesModel.fromMap(Map<String, dynamic> map) {
    isDBCreated = map["isDBCreated"] ?? null;
    themeMap = map["themeMap"] ?? null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "isDBCreated": isDBCreated ?? null,
      "themeMap": themeMap ?? null
    };
    return map;
  }
}
