import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:judge/data/models/export.dart';

part 'auth_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final GoTrueClient _client;
  final Logger? _logger;

  AuthDataSourceImpl(this._client, {required Logger? logger})
    : _logger = logger;

  @override
  Stream<AppAuthUser?> get authStream => _client.onAuthStateChange
      .map((data) => data.session)
      .distinct()
      .map((session) => session?.user)
      .map(_user2AppAutUser);

  @override
  AppAuthUser? get currentUser => _user2AppAutUser(_client.currentUser);

  @override
  Future<AppAuthUser?> signIn(SignInRequest model) async {
    _logger?.t('sign in request - email:${model.email}');
    return await _client
        .signInWithPassword(email: model.email, password: model.password)
        .then((res) => res.user)
        .then(_user2AppAutUser);
  }

  @override
  Future<AppAuthUser?> signUp(SignUpRequest model) async {
    _logger?.t('sign up request - email:${model.email}');
    return await _client
        .signUp(email: model.email, password: model.password)
        .then((res) => res.user)
        .then(_user2AppAutUser);
  }

  @override
  Future<void> signOut() async {
    await _client.signOut(scope: SignOutScope.global);
  }

  AppAuthUser? _user2AppAutUser(User? user) {
    return user == null ? null : AppAuthUser.from(user.toJson());
  }
}
