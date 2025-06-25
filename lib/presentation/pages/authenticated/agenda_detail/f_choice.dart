import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

class ChoiceFragment extends StatefulWidget {
  const ChoiceFragment(this._agenda, {super.key});

  final Agenda _agenda;

  @override
  State<ChoiceFragment> createState() => _ChoiceFragmentState();
}

class _ChoiceFragmentState extends State<ChoiceFragment> with DebounceMixin {
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  _handleSelect(int index) => () {
    setState(() {
      _current = index;
    });
  };

  _handleSubmit() async => await debounce(() async {
    context.read<ChoiceCubit>().editOption(_current);
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tag),
                8.width,
                Text(
                  widget._agenda.title,
                  overflow: TextOverflow.clip,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            24.height,
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget._agenda.options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: _handleSelect(index),
                  leading: Icon(
                    _current == index
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                  ),
                  title: Text(widget._agenda.options[index]),
                );
              },
            ),
            Align(
              alignment: Alignment.center,
              child: BlocBuilder<ChoiceCubit, ChoiceState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: ElevatedButton(
                      onPressed: state.status == Status.loading
                          ? null
                          : _handleSubmit,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("VOTE")],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
