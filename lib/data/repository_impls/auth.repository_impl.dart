import 'package:injectable/injectable.dart';

import 'package:judge/data/datasources/export.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Stream<AppUser?> get userStream =>
      _remoteDataSource.authStream.map(_authUser2AppUser);

  @override
  AppUser? get currentUser => _authUser2AppUser(_remoteDataSource.currentUser);

  @override
  Future<AppUser?> signUp({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource
        .signUp(SignUpRequest(email: email, password: password))
        .then(_authUser2AppUser);
  }

  @override
  Future<AppUser?> signIn({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource
        .signIn(SignInRequest(email: email, password: password))
        .then(_authUser2AppUser);
  }

  @override
  Future<void> signOut() async {
    return await _remoteDataSource.signOut();
  }

  AppUser? _authUser2AppUser(AppAuthUser? e) {
    return e == null ? null : AppUser.from(e);
  }
}
