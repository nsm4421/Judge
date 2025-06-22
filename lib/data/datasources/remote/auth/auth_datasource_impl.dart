import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:judge/shared/export.dart';

import 'package:judge/data/models/export.dart';

import '../datasource_response_wrapper.dart';

part 'auth_datasource.dart';

class AuthDataSourceImpl
    with DataSourceResponseWrapperMixIn
    implements AuthDataSource {
  final GoTrueClient _client;

  AuthDataSourceImpl(this._client);

  @override
  Stream<AppAuthUser?> get authStream => _client.onAuthStateChange
      .map((data) => data.session)
      .distinct()
      .map((session) => session?.user)
      .map(_user2AppAutUser);

  @override
  AppAuthUser? get currentUser => _user2AppAutUser(_client.currentUser);

  @override
  Future<Either<AbsError, AppAuthUser?>> signIn(SignInRequest model) async =>
      await wrap<AppAuthUser?>(() async {
        return await _client
            .signInWithPassword(email: model.email, password: model.password)
            .then((res) => res.user)
            .then(_user2AppAutUser);
      });

  @override
  Future<Either<AbsError, AppAuthUser?>> signUp(SignUpRequest model) async =>
      await wrap<AppAuthUser?>(() async {
        return await _client
            .signUp(email: model.email, password: model.password)
            .then((res) => res.user)
            .then(_user2AppAutUser);
      });

  @override
  Future<Either<AbsError, void>> signOut() async => await wrap<void>(() async {
    return await _client.signOut();
  });

  AppAuthUser? _user2AppAutUser(User? user) {
    return user == null ? null : AppAuthUser.from(user.toJson());
  }
}
