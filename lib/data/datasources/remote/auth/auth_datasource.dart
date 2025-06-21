part of 'auth_datasource_impl.dart';

abstract interface class AuthDataSource {
  Stream<AppAuthUser?> get authStream;

  AppAuthUser? get currentUser;

  Future<AppAuthUser?> signUp(SignUpRequest model);

  Future<AppAuthUser?> signIn(SignInRequest model);

  Future<void> signOut();
}
