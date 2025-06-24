import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

import 'f_choice_modal.dart';

class ChoiceListFragment extends StatelessWidget {
  const ChoiceListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAgendaCubit, CreateAgendaState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.options.length,
          itemBuilder: (context, index) {
            final choice = state.options[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: GestureDetector(
                onTap: () async {
                  await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    builder: (childCtx) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: childCtx.bottomViewPadding,
                        ),
                        child: ChoiceModalFragment(
                          initValue: choice,
                          options: state.options,
                        ),
                      );
                    },
                  ).then((text) {
                    if (text != null) {
                      context.read<CreateAgendaCubit>().updateChoice(
                        index: index,
                        choice: text,
                      );
                    }
                  }).whenComplete((){
                    FocusScope.of(context).unfocus();
                  });
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          '[${index + 1}] $choice',
                          style: context.textTheme.bodyLarge,
                          softWrap: true,
                        ),
                        Spacer(),
                        if (state.options.length > 1)
                          IconButton(
                            onPressed: () {
                              context.read<CreateAgendaCubit>().removeChoice(
                                index,
                              );
                            },
                            icon: Icon(Icons.delete_outline),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
