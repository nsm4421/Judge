import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/dependency_injection.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';
import 'package:oktoast/oktoast.dart';

import 's_display_agendas.dart';

@RoutePage()
class DisplayAgendasPage extends StatelessWidget {
  const DisplayAgendasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DisplayAgendasBloc>()..add(DisplayMountedEvent()),
      child: BlocListener<DisplayAgendasBloc, AbsDisplayState<Agenda>>(
        listener: (context, state) {
          if (state.status == Status.error && state.isMounted) {
            // 첫 로딩 시 오류면,  toast를 띄우고 1초뒤 다시 가져오기 요청
            showToast(state.message);
            context.read<DisplayAgendasBloc>().add(
              UpdateDisplayStatusEvent(status: Status.initial, message: ''),
            );
            Timer(1.durationInSec, () {
              context.read<DisplayAgendasBloc>().add(DisplayMountedEvent());
            });
          }
        },
        child: DisplayAgendasScreen(),
      ),
    );
  }
}
