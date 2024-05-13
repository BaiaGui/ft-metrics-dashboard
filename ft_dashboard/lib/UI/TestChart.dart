import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  const MyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[200],
              strokeWidth: 1,
            );
          },
        ),
        //clipData: FlClipData.all(),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 30,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 30,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            top: BorderSide(color: Colors.grey[200]!),
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            color: Colors.amber,
            isCurved: true,
            spots: [
              FlSpot(0, 0),
              FlSpot(3, 1.5),
              FlSpot(5, 2.4),
              FlSpot(7, 3.4),
              FlSpot(10, 4),
              FlSpot(13, 5.2),
              FlSpot(16, 6),
            ],
          ),
          LineChartBarData(
            color: Colors.green,
            isCurved: true,
            spots: [
              FlSpot(0, 0),
              FlSpot(1, 1.5),
              FlSpot(2, 2.4),
              FlSpot(3, 3.4),
              FlSpot(4, 4),
              FlSpot(5, 5.2),
              FlSpot(6, 6),
              FlSpot(7, 4),
              FlSpot(8, 1.5),
              FlSpot(9, 2.4),
              FlSpot(10, 3.4),
              FlSpot(11, 4),
              FlSpot(12, 5.2),
              FlSpot(16, 6),
            ],
          ),
          LineChartBarData(
            isCurved: true,
            spots: [
              FlSpot(0, 0),
              FlSpot(2, 1.5),
              FlSpot(4, 1.4),
              FlSpot(6, 3.4),
              FlSpot(8, 2),
              FlSpot(10, 2.2),
              FlSpot(12, 1.8),
            ],
          ),
        ],
      ),
    );
  }
}
