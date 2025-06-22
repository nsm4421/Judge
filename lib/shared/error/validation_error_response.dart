import 'abs_error_response.dart';

class ValidationError extends AbsError {
  ValidationError(String message)
    : super(type: ErrorType.validation, message: message);
}
