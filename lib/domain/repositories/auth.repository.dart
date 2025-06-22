import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/shared/export.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get userStream;

  AppUser? get currentUser;

  Future<Either<AbsError, AppUser?>> signUp({
    required String email,
    required String password,
    required String username,
  });

  Future<Either<AbsError, AppUser?>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AbsError, void>> signOut();
}
