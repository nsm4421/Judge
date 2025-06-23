import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/presentation/routes/export.dart';

import 'f_display_agendas.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.pushRoute(CreateAgendaRoute());
            },
            icon: Icon(Icons.add_box_outlined),
          ),
          IconButton(
            onPressed: () {
              context
                ..read<AuthenticationBloc>().add(SignOutEvent())
                ..replaceRoute(SignInRoute());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: DisplayAgendasFragment(),
    );
  }
}
