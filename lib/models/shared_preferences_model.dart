class SharedPreferencesModel {
  bool isDBCreated;

  SharedPreferencesModel.fromMap(Map<String, dynamic> map) {
    isDBCreated = map["isDBCreated"] ?? NullThrownError();
  }
}
