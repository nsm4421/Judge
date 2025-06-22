import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/dependency_injection.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/presentation/routes/export.dart';
import 'package:judge/shared/export.dart';
import 'package:oktoast/oktoast.dart';

import 's_sign_up.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpCubit>(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            showToast(state.message);
            Timer(1.durationInSec, () {
              context.read<SignUpCubit>().updateStatus(
                status: Status.initial,
                message: '',
              );
            });
          } else if (state.status == Status.success) {
            showToast('회원가입에 성공하였습니다');
            context.replaceRoute(EntryRoute());
          }
        },
        child: const SignUpScreen(),
      ),
    );
  }
}
