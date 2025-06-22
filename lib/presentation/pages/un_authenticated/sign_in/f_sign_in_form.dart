import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

class SignInFormFragment extends StatefulWidget {
  const SignInFormFragment({super.key});

  @override
  State<SignInFormFragment> createState() => _SignInFormFragmentState();
}

class _SignInFormFragmentState extends State<SignInFormFragment> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()..addListener(_handleEmail);
    _passwordController = TextEditingController()..addListener(_handlePassword);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController
      ..removeListener(_handleEmail)
      ..dispose();
    _passwordController
      ..removeListener(_handlePassword)
      ..dispose();
  }

  String? _validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "이메일을 입력해주세요";
    }
    return null;
  }

  String? _validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "비밀번호를 입력해주세요";
    }
    return null;
  }

  _handleEmail() {
    context.read<SignInCubit>().updateData(email: _emailController.text.trim());
  }

  _handlePassword() {
    context.read<SignInCubit>().updateData(
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  validator: _validateEmail,
                ),
              ],
            ),
          ),
          16.height,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: _validatePassword,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
