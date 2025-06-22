import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/presentation/providers/export.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entry Screen"),
        actions: [
          IconButton(onPressed: (){
            context.read<AuthenticationBloc>().add(SignOutEvent());
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
