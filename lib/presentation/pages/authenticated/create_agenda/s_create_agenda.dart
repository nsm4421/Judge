import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'f_title_form.dart';
import 'w_choice_header.dart';
import 'f_choice_list.dart';
import 'w_submit_button.dart';

class CreateAgendaScreen extends StatelessWidget {
  const CreateAgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await context.maybePop();
          },
          icon: Icon(Icons.clear),
        ),
        title: Text('What your problem?'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: TitleFormFragment(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ChoicesHeaderWidget(), ChoiceListFragment()],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SubmitButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
