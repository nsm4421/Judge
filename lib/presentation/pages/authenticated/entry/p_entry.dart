import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 's_entry.dart';

@RoutePage()
class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EntryScreen();
  }
}
