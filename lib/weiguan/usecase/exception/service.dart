import 'common.dart';

class ServiceException extends UseCaseException {
  ServiceException(String message) : super(message);
}

class ServiceRequestFail extends ServiceException {
  ServiceRequestFail(String message) : super(message);
}

class ServiceResponseFail extends ServiceException {
  ServiceResponseFail(String message) : super(message);
}

class ServiceResponseDuplicate extends ServiceException {
  ServiceResponseDuplicate(String message) : super(message);
}
