import 'package:ecommerce_mobile_app/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.complete(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;
}