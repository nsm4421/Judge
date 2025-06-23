import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

class TitleFormFragment extends StatefulWidget {
  const TitleFormFragment({super.key});

  @override
  State<TitleFormFragment> createState() => _TitleFormFragmentState();
}

class _TitleFormFragmentState extends State<TitleFormFragment> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_handleTitle);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_handleTitle)
      ..dispose();
  }

  _handleTitle() {
    context.read<CreateAgendaCubit>().updateTitle(_controller.text.trim());
  }

  String? _validator(text) =>
      (text?.trim().isEmpty ?? true) ? '제목을 입력해주세요' : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Agenda',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(controller: _controller, validator: _validator),
      ],
    );
  }
}
