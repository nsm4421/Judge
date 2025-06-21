part of 'auth.bloc.dart';

@CopyWith(copyWithNull: true)
class AuthenticationState {
  final Status status;
  final String message;
  final AppUser? user;

  AuthenticationState({
    this.status = Status.initial,
    this.message = '',
    this.user,
  });

  bool get isAuth => user != null;
}
