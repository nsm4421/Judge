import 'abs_error_response.dart';

class NetworkError extends AbsError {
  NetworkError(String message)
      : super(type: ErrorType.network, message: message);
}
