import 'package:ecommerce_mobile_app/data/network/network_api_service.dart';
import 'package:ecommerce_mobile_app/models/categories.dart';
import 'package:ecommerce_mobile_app/res/app_url.dart';

class CategoryRepository {
  final NetworkApiService _apiService = NetworkApiService();
  final String token;

  CategoryRepository({required this.token});

  Future<CategoryListModel> getCategories() async {
    try {
      // Await the API response and pass the token
      dynamic response = await _apiService.getApiResponse(
        AppUrl.categories,
        token: token,
      );

      // Parse the response into CategoryListModel
      CategoryListModel categoryListModel = CategoryListModel.fromJson(response);

      // Return the parsed categories
      return categoryListModel;
    } catch (error) {
      // Handle any errors
      rethrow;
    }
  }

}