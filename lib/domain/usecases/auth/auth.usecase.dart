import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'scenario/sign_out.usecase.dart';
import 'scenario/sign_up.usecase.dart';
import 'scenario/sign_in.usecase.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Stream<AppUser?> get userStream => _repository.userStream;

  AppUser? get currentUser => _repository.currentUser;

  SignUpUseCase get signUp => SignUpUseCase(_repository);

  SignInUseCase get signIn => SignInUseCase(_repository);

  SignOutUseCase get signOut => SignOutUseCase(_repository);
}
