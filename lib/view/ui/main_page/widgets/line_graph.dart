import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineGraph extends StatelessWidget {
  LineGraph(this.data, {Key? key}) : super(key: key);

  final List<int> data;
  late final double maxData = max(data).toDouble();
  late final int scale = (maxData ~/ 25) * 5;

  int max(List<int> list) {
    int max = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
      }
    }
    return max == 0 ? 100 : max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(top: 15, bottom: 0, left: 8, right: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: AspectRatio(
        aspectRatio: 1.8,
        child: LineChart(
          mainData(context),
        ),
      ),
    );
  }

  LineChartData mainData(BuildContext context) {
    return LineChartData(
        minX: 0,
        maxX: data.length.toDouble(),
        minY: 0,
        maxY: maxData,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(data.length, (index) {
              return FlSpot(index.toDouble(), data[index].toDouble());
            }).toList(),
            // isCurved: true,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: false,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: scale.toDouble(),
              getTitlesWidget: (val, _) => Text(
                val % (scale) == 0 ? "${val.round()}" : '',
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (val, _) => Text(
              '',
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          )),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              strokeWidth: 0.25,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              strokeWidth: 0.25,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
              bottom: BorderSide(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                width: 0.5,
              ),
              left: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5),
                  width: 0.5)),
        ));
  }
}
