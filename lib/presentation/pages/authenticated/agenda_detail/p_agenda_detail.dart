import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/dependency_injection.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';

import 's_agenda_detail.dart';

@RoutePage()
class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage(this._agenda, {super.key});

  final Agenda _agenda;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChoiceCubit>(param1: _agenda)..mount(),
      child: AgendaDetailScreen(),
    );
  }
}
