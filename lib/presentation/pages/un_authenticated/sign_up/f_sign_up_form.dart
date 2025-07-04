import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

class SignUpFormFragment extends StatefulWidget {
  const SignUpFormFragment({super.key});

  @override
  State<SignUpFormFragment> createState() => _SignUpFormFragmentState();
}

class _SignUpFormFragmentState extends State<SignUpFormFragment> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()..addListener(_handleEmail);
    _passwordController = TextEditingController()..addListener(_handlePassword);
    _usernameController = TextEditingController()..addListener(_handleUsername);
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
    _usernameController
      ..removeListener(_handleUsername)
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

  String? _validateUsername(String? text) {
    if (text == null || text.isEmpty) {
      return "유저명을 입력해주세요";
    }
    return null;
  }

  _handleEmail() {
    context.read<SignUpCubit>().updateData(email: _emailController.text.trim());
  }

  _handlePassword() {
    context.read<SignUpCubit>().updateData(
      password: _passwordController.text.trim(),
    );
  }

  _handleUsername() {
    context.read<SignUpCubit>().updateData(
      username: _usernameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
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
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: _validateEmail,
                  controller: _emailController,
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: _validatePassword,
                  controller: _passwordController,
                  obscureText: true,
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: _validateUsername,
                  controller: _usernameController,
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
