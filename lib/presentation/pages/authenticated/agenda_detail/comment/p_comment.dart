import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/dependency_injection.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 's_comment.dart';

@RoutePage()
class CommentPage extends StatelessWidget {
  const CommentPage(this._agenda, {super.key});

  final Agenda _agenda;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<CreateParentCommentCubit>(param1: _agenda.id, param2: null),
        ),
      ],
      child: CommentScreen(),
    );
  }
}
