import 'abs_error_response.dart';

class UnExpectedError extends AbsError {
  UnExpectedError({required super.message})
    : super(type: ErrorType.unexpected);
}
