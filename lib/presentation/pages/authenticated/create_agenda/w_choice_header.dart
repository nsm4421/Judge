import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

import 'f_choice_modal.dart';

class ChoicesHeaderWidget extends StatelessWidget {
  const ChoicesHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAgendaCubit, CreateAgendaState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Choices',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),

            /// 선택지 추가하기 버튼
            IconButton(
              onPressed: () async {
                await showModalBottomSheet<String>(
                      context: context,
                      isScrollControlled: true,
                      builder: (childCtx) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: childCtx.bottomViewPadding,
                          ),
                          child: ChoiceModalFragment(options: state.options),
                        );
                      },
                    )
                    .then((text) {
                      if (text != null) {
                        context.read<CreateAgendaCubit>().addChoice(text);
                      }
                    })
                    .whenComplete(() {
                      FocusScope.of(context).unfocus();
                    });
              },
              icon: Icon(Icons.add_circle_outline),
            ),
          ],
        );
      },
    );
  }
}
