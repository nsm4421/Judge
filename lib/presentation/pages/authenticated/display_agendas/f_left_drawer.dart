import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/presentation/routes/export.dart';
import 'package:judge/shared/export.dart';

class LeftDrawerFragment extends StatelessWidget {
  const LeftDrawerFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          DrawerHeader(
            child: Center(
              child: Text('Menus', style: context.textTheme.displaySmall),
            ),
          ),
          ListTile(
            onTap: () {
              context.pushRoute(CreateAgendaRoute());
            },
            title: Row(
              children: [
                Icon(Icons.add_box_outlined),
                8.width,
                Text('Create Agenda', style: context.textTheme.titleSmall),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              context
                ..read<AuthenticationBloc>().add(SignOutEvent())
                ..replaceRoute(SignInRoute());
            },
            title: Row(
              children: [
                Icon(Icons.logout),
                8.width,
                Text('Logout', style: context.textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
