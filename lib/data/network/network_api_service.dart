import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../app_exception.dart';

class NetworkApiService {
  Future<dynamic> getApiResponse(String url, {String? token}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(Uri.parse(url), headers: headers);
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      // Log the exception
      print('Unexpected error: $e');
      throw FetchDataException('Unexpected error occurred');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorisedException();
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with StatusCode: ${response.statusCode}');
    }
  }
}
