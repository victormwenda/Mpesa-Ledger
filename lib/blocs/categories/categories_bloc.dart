import 'dart:async';

import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/repository/category_repository.dart';

class CategoriesBloc extends BaseBloc {

  CategoryRepository _categoryRepository = CategoryRepository();

  StreamController<List<Map<String, dynamic>>> _categoriesController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get categoriesStream => _categoriesController.stream;
  StreamSink<List<Map<String, dynamic>>> get categoriesSink => _categoriesController.sink;

  CategoriesBloc() {
    print("started");
    _getCategoryData();
  }

  Future<void> _getCategoryData() async {
    List<Map<String, dynamic>> listMap = [];
    var result = await _getCategories();
    for (var i = 0; i < result.length; i++) {
      listMap.add(result[i].toMap());
    }
    categoriesSink.add(listMap);
  }


  Future<List<CategoryModel>> _getCategories() async {
    return await _categoryRepository.select();
  }

  @override
  void dispose() {
    
  }
  
}