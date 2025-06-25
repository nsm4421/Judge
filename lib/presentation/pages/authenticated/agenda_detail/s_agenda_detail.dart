import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';

import 'f_count_chart.dart';
import 'f_choice.dart';

class AgendaDetailScreen extends StatelessWidget {
  const AgendaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agenda = context.read<ChoiceCubit>().agenda;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ChoiceCubit, ChoiceState>(
        builder: (BuildContext context, ChoiceState state) {
          return state.selected == null
              ? Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ChoiceFragment(agenda),
                    ),
                    Spacer(flex: 2),
                  ],
                )
              : Column(children: [CountChartFragment(agenda)]);
        },
      ),
    );
  }
}
