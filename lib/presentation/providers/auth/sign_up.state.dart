part of 'sign_up.cubit.dart';

@CopyWith()
class SignUpState extends AbsBlocState {
  final String email;
  final String password;

  SignUpState({
    super.status,
    super.message,
    this.email = '',
    this.password = '',
  });
}
