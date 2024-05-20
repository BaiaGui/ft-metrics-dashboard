import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MainChart extends StatelessWidget {
  const MainChart({super.key});

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
        titlesData: const FlTitlesData(
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
              const FlSpot(0, 0),
              const FlSpot(3, 1.5),
              const FlSpot(5, 2.4),
              const FlSpot(7, 3.4),
              const FlSpot(10, 4),
              const FlSpot(13, 5.2),
              const FlSpot(16, 6),
            ],
          ),
          LineChartBarData(
            color: Colors.green,
            isCurved: true,
            spots: [
              const FlSpot(0, 0),
              const FlSpot(1, 1.5),
              const FlSpot(2, 2.4),
              const FlSpot(3, 3.4),
              const FlSpot(4, 4),
              const FlSpot(5, 5.2),
              const FlSpot(6, 6),
              const FlSpot(7, 4),
              const FlSpot(8, 1.5),
              const FlSpot(9, 2.4),
              const FlSpot(10, 3.4),
              const FlSpot(11, 4),
              const FlSpot(12, 5.2),
              const FlSpot(16, 6),
            ],
          ),
          LineChartBarData(
            isCurved: true,
            spots: [
              const FlSpot(0, 0),
              const FlSpot(2, 1.5),
              const FlSpot(4, 1.4),
              const FlSpot(6, 3.4),
              const FlSpot(8, 2),
              const FlSpot(10, 2.2),
              const FlSpot(12, 1.8),
            ],
          ),
        ],
      ),
    );
  }
}
