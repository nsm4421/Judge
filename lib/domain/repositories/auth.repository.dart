import 'package:judge/domain/entities/export.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get userStream;

  AppUser? get currentUser;

  Future<AppUser?> signUp({required String email, required String password});

  Future<AppUser?> signIn({required String email, required String password});

  Future<void> signOut();
}
