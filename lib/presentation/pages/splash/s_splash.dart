import 'package:flutter/material.dart';
import 'package:judge/shared/export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("결정장애를 위한 앱", style: context.textTheme.displayLarge),
      ),
    );
  }
}
