import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/dependency_injection.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';
import 'package:oktoast/oktoast.dart';

import 's_create_agenda.dart';

@RoutePage()
class CreateAgendaPage extends StatelessWidget {
  const CreateAgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateAgendaCubit>()..addChoice(''),
      child: BlocListener<CreateAgendaCubit, CreateAgendaState>(
        listener: (context, state) async {
          if (state.status == Status.success) {
            showToast('Success!');
            await context.maybePop();
          } else if (state.status == Status.error) {
            showToast(state.message);
            Timer(1.durationInSec, () {
              context.read<CreateAgendaCubit>().updateStatus(
                status: Status.initial,
                message: '',
              );
            });
          }
        },
        child: CreateAgendaScreen(),
      ),
    );
  }
}
