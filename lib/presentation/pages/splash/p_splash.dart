import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/presentation/routes/export.dart';
import 'package:judge/shared/export.dart';
import 's_splash.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final StreamSubscription<AppUser?> _userStreamSubscription;

  @override
  void initState() {
    super.initState();
    _userStreamSubscription = context
        .read<AuthenticationBloc>()
        .userStream
        .listen((data) {
          Timer(2.durationInSec, () {
            context.router.replace(data == null ? SignInRoute() : EntryRoute());
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    _userStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
