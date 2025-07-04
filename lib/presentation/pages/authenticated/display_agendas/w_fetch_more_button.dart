import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

class FetchMoreButtonWidget extends StatelessWidget {
  const FetchMoreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayAgendasBloc, AbsDisplayState<Agenda>>(
      builder: (context, state) {
        if (!state.isMounted || state.isEnd) {
          return SizedBox.shrink();
        }
        return ElevatedButton(
          onPressed: state.status == Status.loading
              ? null
              : () {
                  context.read<DisplayAgendasBloc>().add(DisplayFetchEvent());
                },
          child: Text("Fetch More"),
        );
      },
    );
  }
}
