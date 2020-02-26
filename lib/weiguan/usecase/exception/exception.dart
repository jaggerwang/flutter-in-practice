class UsecaseException implements Exception {
  final String message;

  UsecaseException(this.message);

  @override
  String toString() {
    return 'UsecaseException(message: $message)';
  }
}

class UnauthenticatedException extends UsecaseException {
  UnauthenticatedException(String message) : super(message);
}

class ServiceException extends UsecaseException {
  final String code;

  ServiceException(this.code, String message) : super(message);

  @override
  String toString() {
    return 'UsecaseException(code: $code, message: $message)';
  }
}
