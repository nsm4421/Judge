import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';
import 'package:logger/logger.dart';

class SignInUseCase {
  final AuthRepository _repository;
  final Logger? logger;

  SignInUseCase(this._repository, {this.logger});

  Future<Either<ErrorResponse, AppUser?>> call({
    required String email,
    required String password,
  }) async {
    try {
      return await _repository
          .signIn(email: email, password: password)
          .then(Right.new);
    } catch (error) {
      logger?.e(error);
      return Left(
        ErrorResponse(type: 'unknown', description: error.toString()),
      );
    }
  }
}
