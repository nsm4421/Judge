import 'package:flutter/material.dart';
import 'w_navigate_sign_up_button.dart';
import 'f_sign_in_form.dart';
import 'w_submit_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SingleChildScrollView(child: SignInFormFragment()),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 36),
            child: SubmitButtonWidget(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: 36,
            ),
            child: NavigateSignUpButtonWidget(),
          ),
        ],
      ),
    );
  }
}
