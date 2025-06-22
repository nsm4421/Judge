import 'dart:collection';

import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class SignUpContext {
  final String email;
  final String password;
  final String username;
  AppUser? user;

  SignUpContext({
    required this.email,
    required this.password,
    required this.username,
    this.user,
  });
}

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<AbsError, AppUser?>> call({
    required String email,
    required String password,
    required String username,
  }) async {
    final ctx = SignUpContext(
      email: email,
      password: password,
      username: username,
    );
    final tasks = ListQueue<Future<Either<AbsError, void>> Function()>();
    tasks.addAll([
      () async {
        final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        return !emailReg.hasMatch(ctx.email)
            ? Left(ValidationError('올바른 이메일 형식을 입력해주세요|$email'))
            : Right(null);
      },
      () async {
        return ctx.password.length < 6
            ? Left(ValidationError('비밀번호는 최소 6자 이상이어야 합니다'))
            : Right(null);
      },
      () async {
        return ctx.username.length < 2
            ? Left(ValidationError('유저명은 최소 2자 이상이어야 합니다|$username'))
            : Right(null);
      },
      () async {
        final res = await _repository.signUp(email: email, password: password, username:username);
        if (res.isRight) {
          ctx.user = res.right;
        }
        return res;
      },
    ]);

    while (tasks.isNotEmpty) {
      final task = tasks.removeFirst();
      final res = await task();
      if (res.isLeft) {
        return Left(res.left);
      }
    }

    return Right(ctx.user);
  }
}
