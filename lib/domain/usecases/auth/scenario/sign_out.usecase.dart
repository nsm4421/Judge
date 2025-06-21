import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';
import 'package:logger/logger.dart';

class SignOutUseCase {
  final AuthRepository _repository;
  final Logger? logger;

  SignOutUseCase(this._repository, {this.logger});

  Future<Either<ErrorResponse, void>> call() async {
    try {
      return await _repository.signOut().then(Right.new);
    } catch (error) {
      logger?.e(error);
      return Left(
        ErrorResponse(type: 'unknown', description: error.toString()),
      );
    }
  }
}
