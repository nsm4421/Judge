import 'abs_error_response.dart';

enum AuthErrorCode {
  invalidCredentials('이메일 또는 비밀번호가 올바르지 않습니다'),
  emailNotConfirmed('이메일 인증이 필요합니다'),
  emailExists('이미 존재하는 이메일입니다'),
  weakPassword('비밀번호가 보안에 취약합니다'),
  userNotFound('존재하지 않는 유저입니다'),
  userAlreadyExists('이미 존재하는 유저입니다'),
  unKnown('알수없는 인증오류가 발생했습니다');

  final String message;

  const AuthErrorCode(this.message);
}

class AuthError extends AbsError {
  final AuthErrorCode code;

  AuthError({required this.code, String? message})
    : super(message: message ?? code.message, type: ErrorType.supabase);

  @override
  String toString() {
    return '[AuthError-$code]$message';
  }
}
