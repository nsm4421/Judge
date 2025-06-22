import 'package:either_dart/either.dart';
import 'package:judge/shared/export.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin class DataSourceResponseWrapperMixIn {
  final _logger = Logger();

  Future<Either<AbsError, R>> wrap<R>(Future<R> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on AuthException catch (e) {
      _logger.e(['[DataSource][AuthException]', e]);
      return Left(AuthError(code: _getAuthErrorCode(e.code)));
    } on PostgrestException catch (e) {
      _logger.e(['[DataSource][PostgrestException]', e]);
      return Left(DatabaseError(code: _getDatabaseErrorCode(e.code)));
    } on StorageException catch (e) {
      _logger.e(['[DataSource][StorageException]', e]);
      return Left(StorageError(code: _getStorageErrorCode(e.error)));
    } catch (e) {
      _logger.e(['[DataSource][UnExpectedError]', e]);
      return Left(UnExpectedError(message: '알 수 없는 오류가 발생했습니다'));
    }
  }

  // supabase의 AuthException 코드별 오류 유형
  AuthErrorCode _getAuthErrorCode(String? supErrorCode) {
    return switch (supErrorCode) {
      'invalid_credentials' => AuthErrorCode.invalidCredentials,
      'email_not_confirmed' => AuthErrorCode.emailNotConfirmed,
      'email_exists' => AuthErrorCode.emailExists,
      'user_not_found' => AuthErrorCode.userNotFound,
      'weak_password' => AuthErrorCode.weakPassword,
      'user_already_exists' => AuthErrorCode.userAlreadyExists,
      (_) => AuthErrorCode.unKnown,
    };
  }

  // supabase의 PostgrestException 코드별 오류 유형
  DatabaseErrorCode _getDatabaseErrorCode(String? supErrorCode) {
    return DatabaseErrorCode.values.firstWhere(
      (e) => e.code == supErrorCode,
      orElse: () => DatabaseErrorCode.unknown,
    );
  }

  // supabase의 StorageException 코드별 오류 유형
  StorageErrorCode _getStorageErrorCode(String? supErrorCode) {
    return StorageErrorCode.values.firstWhere(
      (e) => e.code == supErrorCode,
      orElse: () => StorageErrorCode.unknown,
    );
  }
}
