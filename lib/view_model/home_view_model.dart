import 'package:ecommerce_mobile_app/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import '../models/products.dart';


class ProductViewModel extends ChangeNotifier{
  final ProductRepository _repository;
  ProductModel? _productModel;
  String? _errorMessage;
  bool _isLoading = false;

  ProductViewModel({required String token})
      : _repository = ProductRepository(token: token);

  ProductModel? get productModel => _productModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async{
    _isLoading = true;
    notifyListeners();

    try {
      _productModel = await _repository.getProducts();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
      _productModel = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}