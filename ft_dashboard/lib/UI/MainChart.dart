import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/Bloc/general_status_bloc.dart';
import 'package:ft_dashboard/data/utils.dart';

class MainChart extends StatelessWidget {
  const MainChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
        builder: (context, state) {
      if (state.mainChartLinePoints.isNotEmpty) {
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
    List<FlSpot> spots = [];
    for (var line in state.mainChartLinePoints) {
      spots.add(FlSpot(line[0], line[1]));
    }

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
            spots: [],
          ),
          LineChartBarData(
            color: Colors.green,
            isCurved: true,
            spots: spots,
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
  String text = transformXcoordToYear(value.toInt());

  return Text(
    text,
    style: TextStyle(
      color: Colors.grey[600],
      fontSize: 12,
    ),
  );
}
