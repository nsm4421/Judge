import 'package:copy_with_extension/copy_with_extension.dart';

part 'error_response.g.dart';

@CopyWith()
class ErrorResponse {
  final String type;
  final String message;
  final String description;

  ErrorResponse({this.type = '', this.message = '', this.description = ''});
}
