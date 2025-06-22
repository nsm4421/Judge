import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:judge/presentation/routes/export.dart';
import 'package:judge/shared/export.dart';

class NavigateSignUpButtonWidget extends StatelessWidget {
  const NavigateSignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        context.pushRoute(SignUpRoute());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.secondaryContainer,
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "회원가입",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );;
  }
}
