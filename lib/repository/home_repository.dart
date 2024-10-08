import '../data/network/network_api_service.dart';
import '../models/products.dart';
import '../res/app_url.dart';

class ProductRepository{
  final NetworkApiService _apiService = NetworkApiService();
  final String token;

  ProductRepository({required this.token}); // Add a token

  Future<ProductModel> getProducts() async{
    try{
      // Await the API response and pass the token
      dynamic response = await _apiService.getApiResponse(
          AppUrl.products,
          token: token
      );

      // Parse the response into ProductModel
      ProductModel productModel = ProductModel.fromJson(response);
      return productModel;
    } catch (error){
      // Handle any errors that happened
      rethrow;
    }
  }
}