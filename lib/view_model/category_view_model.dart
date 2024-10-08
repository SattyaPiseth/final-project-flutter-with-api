import 'package:ecommerce_mobile_app/models/categories.dart';
import 'package:ecommerce_mobile_app/repository/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;
  CategoryListModel? _categoryListModel;
  String? _errorMessage;
  bool _isLoading = false;

  CategoryViewModel({required String token})
      : _repository = CategoryRepository(token: token);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CategoryListModel? get categoryListModel => _categoryListModel;

  Future<void> fetchCategory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categoryListModel = await _repository.getCategories();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
      _categoryListModel = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
