// lib/exceptions/app_exception.dart

class AppException implements Exception {
  final String message;
  final String? prefix;
  final String? suffix;

  AppException(this.message, {this.prefix, this.suffix});

  @override
  String toString() {
    return (prefix ?? '') + message + (suffix ?? '');
  }
}

class BadRequestException extends AppException {
  BadRequestException([super.message = 'Bad Request'])
      : super(prefix: 'Bad Request: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([super.message = 'Unauthorised'])
      : super(prefix: 'Unauthorised: ');
}

class FetchDataException extends AppException {
  FetchDataException([super.message = 'Error during communication with server'])
      : super(prefix: 'Fetch Data Error: ');
}
