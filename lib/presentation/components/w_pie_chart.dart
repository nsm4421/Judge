import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  PieChartWidget({
    super.key,
    required this.palette,
    required this.labels,
    required this.counts,
  }) {
    assert(
      (labels.length == counts.length) &&
          (counts.length == palette.length) &&
          labels.isNotEmpty,
    );
  }

  final List<Color> palette;
  final List<String> labels;
  final List<int> counts;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int _touchedIndex = -1;
  late final int _total;

  @override
  void initState() {
    super.initState();
    _total = widget.counts.reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                _touchedIndex = -1;
                return;
              }
              _touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: List.generate(widget.labels.length, (index) {
          final isTouched = index == _touchedIndex;
          return PieChartSectionData(
            color: widget.palette[index],
            value: widget.counts[index] / _total,
            title: widget.counts[index].toString(),
            radius: isTouched ? 60 : 50,
            titleStyle: TextStyle(
              fontSize: isTouched ? 25 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
            ),
          );
        }),
      ),
    );
  }
}
