import 'package:flutter/material.dart';

import 'f_display_agendas.dart';
import 'f_left_drawer.dart';

class DisplayAgendasScreen extends StatelessWidget {
  const DisplayAgendasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawerFragment(),
      appBar: AppBar(title: Text("Agendas")),
      body: DisplayAgendasFragment(),
    );
  }
}
