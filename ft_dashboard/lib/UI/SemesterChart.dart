import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SemesterChart extends StatelessWidget {
  const SemesterChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: BarChart(
        BarChartData(
          borderData:
              FlBorderData(border: Border.all(color: Colors.grey[300]!)),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              axisNameSize: 40,
              axisNameWidget: Text(
                "Curso",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              sideTitles: SideTitles(
                reservedSize: 300,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ),
            ),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(interval: 5, showTitles: true)),
          ),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 1,
              );
            },
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 5,
                  width: 42,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 3,
                  width: 42,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 2,
                  width: 42,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 4,
                  width: 42,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  toY: 3,
                  width: 42,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  toY: 5,
                  width: 42,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getBottomTitles(value, meta) {
    String text = "";

    switch (value.toInt()) {
      case 0:
        text = "Não sei avaliar";
      case 1:
        text = "DT";
      case 2:
        text = "DP";
      case 3:
        text = "Neutro";
      case 4:
        text = "CP";
      case 5:
        text = "CT";
    }
    return Text(
      text,
      style: TextStyle(color: Colors.grey[600]),
    );
  }
}
