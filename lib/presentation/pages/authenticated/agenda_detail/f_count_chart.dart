import 'package:flutter/material.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/components/export.dart';
import 'package:judge/shared/export.dart';

class CountChartFragment extends StatefulWidget {
  const CountChartFragment(this._agenda, {super.key});

  final Agenda _agenda;

  @override
  State<CountChartFragment> createState() => _CountChartFragmentState();
}

class _CountChartFragmentState extends State<CountChartFragment> {
  @override
  Widget build(BuildContext context) {
    final palette = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
      Colors.grey,
    ].take(widget._agenda.options.length).toList();

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChartWidget(
                palette: palette,
                labels: widget._agenda.options,
                counts: widget._agenda.counts,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget._agenda.options.length, (index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: palette[index],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget._agenda.options[index],
                    style: context.textTheme.labelLarge,
                  ),
                ],
              );
            }),
          ),
          28.width,
        ],
      ),
    );
  }
}
