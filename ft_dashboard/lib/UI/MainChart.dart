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
              getTitlesWidget: getBottomTitle,
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
              const FlSpot(1, 1.5),
              const FlSpot(2, 2.4),
              const FlSpot(3, 3.4),
              const FlSpot(4, 4),
              const FlSpot(5, 4),
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
              const FlSpot(5, 5),
            ],
          ),
          LineChartBarData(
            isCurved: true,
            spots: [
              const FlSpot(0, 0),
              const FlSpot(1, 1.5),
              const FlSpot(2, 1.4),
              const FlSpot(3, 3.4),
              const FlSpot(4, 2),
              const FlSpot(5, 2.2),
            ],
          ),
        ],
      ),
    );
  }
}

Widget getBottomTitle(value, meta) {
  String text = "";

  switch (value.toInt()) {
    case 0:
      text = "2022.1";
    case 1:
      text = "2022.2";
    case 2:
      text = "2023.1";
    case 3:
      text = "2023.2";
    case 4:
      text = "2024.1";
    case 5:
      text = "2024.2";
  }
  return Text(
    text,
    style: TextStyle(
      color: Colors.grey[600],
      fontSize: 12,
    ),
  );
  return Text("a");
}
