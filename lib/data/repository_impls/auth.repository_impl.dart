import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

import 'package:judge/data/datasources/export.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';
import 'repository_response_wrapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl
    with RepositoryResponseWrapperMixIn
    implements AuthRepository {
  final AuthDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Stream<AppUser?> get userStream =>
      _remoteDataSource.authStream.map(_authUser2AppUser);

  @override
  AppUser? get currentUser => _authUser2AppUser(_remoteDataSource.currentUser);

  @override
  Future<Either<AbsError, AppUser?>> signUp({
    required String email,
    required String password,
    required String username,
  }) async => await wrap<AppAuthUser?, AppUser?>(
    action: () async => await _remoteDataSource.signUp(
      SignUpRequest(email: email, password: password, username: username),
    ),
    rightCallback: _authUser2AppUser,
  );

  @override
  Future<Either<AbsError, AppUser?>> signIn({
    required String email,
    required String password,
  }) async => await wrap<AppAuthUser?, AppUser?>(
    action: () async => await _remoteDataSource.signIn(
      SignInRequest(email: email, password: password),
    ),
    rightCallback: _authUser2AppUser,
  );

  @override
  Future<Either<AbsError, void>> signOut() async =>
      await _remoteDataSource.signOut();

  AppUser? _authUser2AppUser(AppAuthUser? e) {
    return e == null ? null : AppUser.from(e);
  }
}
