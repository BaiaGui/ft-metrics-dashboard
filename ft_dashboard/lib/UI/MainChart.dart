import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/Bloc/main_chart_bloc.dart';

class MainChart extends StatelessWidget {
  const MainChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainChartBloc, MainChartState>(
        builder: (context, state) {
      if (!state.linePoints.isEmpty) {
        return Chart(
          state: state,
        );
      } else {
        return Placeholder();
      }
    });
  }
}

class Chart extends StatelessWidget {
  const Chart({super.key, this.state});

  final state;

  @override
  Widget build(BuildContext context) {
    // final spots = state.linePoints.map(
    //   (line) {
    //     List<FlSpot> list = [];
    //     print(FlSpot(line[0], line[1]));
    //     list.add(FlSpot(line[0], line[1]));
    //     return list.toList();
    //   },
    // );
    // print(spots);
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
              //getTitlesWidget: getBottomTitle,
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
            spots: [],
          ),
          LineChartBarData(
            color: Colors.green,
            isCurved: true,
            spots: [
              FlSpot(state.linePoints[0][0], state.linePoints[0][1]),
              FlSpot(state.linePoints[1][0], state.linePoints[1][1]),
              FlSpot(state.linePoints[2][0], state.linePoints[2][1]),
            ],
          ),
          // LineChartBarData(
          //   isCurved: true,
          //   spots: [
          //     const FlSpot(0, 1),
          //     const FlSpot(1, 1.5),
          //     const FlSpot(2, 1.4),
          //     const FlSpot(3, 3.4),
          //     const FlSpot(4, 2),
          //     const FlSpot(5, 2.2),
          //   ],
          // ),
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
}
