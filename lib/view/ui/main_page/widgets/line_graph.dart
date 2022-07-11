import 'package:bigsize_management_staff/models/user/user_work.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

class LineGraph extends StatelessWidget {
  LineGraph(this.data, {Key? key}) : super(key: key);

  final List<double> data;
  late final double maxData = max(data).toDouble();
  late final int scale = (maxData ~/ 25) * 5;
  var date = DateTime.now();

  double max(List<double> list) {
    double max = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
      }
    }
    return max == 0 ? 100 : max;
  }

  @override
  Widget build(BuildContext context) {
    //print(scale);
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.only(top: 15, bottom: 0, left: 5, right: 0),
      //height: 200,
      decoration: BoxDecoration(
          boxShadow: StyleManager.shadow,
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
              reservedSize: 35,
              interval: scale.toDouble() == 0 ? 1 : scale.toDouble(),
              getTitlesWidget: (val, _) => Text(
                val % (scale) == 0
                    ? MoneyFormatter(amount: val)
                        .output
                        .compactNonSymbol
                        .toString()
                    : val.toString().substring(0, val.toString().indexOf('.')) +
                        "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontFamily: "QuicksandMedium",
                    fontSize: 12),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 30,
            getTitlesWidget: (val, _) => Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                DateFormat("dd/MM").format(DateTime(
                    date.year, date.month, date.day - (6 - val.toInt()))),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
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
