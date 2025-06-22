import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<AbsError, void>> call() async {
    return await _repository.signOut().then(Right.new);
  }
}
