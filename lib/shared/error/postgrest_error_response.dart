import 'abs_error_response.dart';

enum DatabaseErrorCode {
  uniqueViolation(code: '23505', message: '중복된 데이터입니다'),
  foreignKeyViolation(code: '23505', message: '외래키 오류 입니다'),
  notNullViolation(code: '23502', message: 'Not Null 오류입니다'),
  syntaxError(code: '42601', message: '문법 오류입니다'),
  statementTimeout(code: '57014', message: '시간초과 오류입니다'),
  unknown(code: '9999', message: '알수 없는 DB오류가 발생했습니다');

  final String code;
  final String message;

  const DatabaseErrorCode({required this.code, required this.message});
}

class DatabaseError extends AbsError {
  final DatabaseErrorCode code;

  DatabaseError({required this.code, String? message})
    : super(message: message ?? code.message, type: ErrorType.supabase);

  @override
  String toString() {
    return '[DatabaseError-$code]$message';
  }
}
