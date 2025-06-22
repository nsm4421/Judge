part of 'auth.bloc.dart';

@CopyWith(copyWithNull: true)
class AuthenticationState extends AbsBlocState {
  final AppUser? user;

  AuthenticationState({super.status, super.message, this.user});

  bool get isAuth => user != null;
}
