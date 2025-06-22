part of 'sign_in.cubit.dart';

@CopyWith()
class SignInState extends AbsBlocState {
  final String email;
  final String password;

  SignInState({
    super.status,
    super.message,
    this.email = '',
    this.password = '',
  });
}
