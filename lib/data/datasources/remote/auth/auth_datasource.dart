part of 'auth_datasource_impl.dart';

abstract interface class AuthDataSource {
  Stream<AppAuthUser?> get authStream;

  AppAuthUser? get currentUser;

  Future<Either<AbsError, AppAuthUser?>> signUp(SignUpRequest model);

  Future<Either<AbsError, AppAuthUser?>> signIn(SignInRequest model);

  Future<Either<AbsError, void>> signOut();
}
