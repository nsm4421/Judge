part of 'auth.bloc.dart';

abstract class AuthenticationEvent {}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignUpEvent({required this.email, required this.password});
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthenticationEvent {}
