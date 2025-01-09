import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';

import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/utils/utils.dart';

class MainChart extends StatelessWidget {
  const MainChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
        builder: (context, state) {
      MainChartModel? mainChartData = state.mainChartData;
      if (mainChartData != null) {
        return Chart(
          state: mainChartData,
        );
      } else {
        //loanding state
        return Container(
          color: Colors.grey[200],
        );
      }
    });
  }
}

class Chart extends StatelessWidget {
  const Chart({super.key, required this.state});

  final MainChartModel state;

  @override
  Widget build(BuildContext context) {
    //Category 1:  Infraestrutura e Suporte
    final line1 = getLine(state.infrastructureLine);
    //Category 2: Participação do Estudante
    final line2 = getLine(state.studentLine);
    //Category 3: Atuação Docente
    final line3 = getLine(state.teacherLine);

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
            spots: line1,
          ),
          LineChartBarData(
            color: Colors.green,
            isCurved: true,
            spots: line2,
          ),
          LineChartBarData(
            color: Colors.blue,
            isCurved: true,
            spots: line3,
          ),
        ],
        maxY: 1,
        minY: 0.5,
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

List<FlSpot> getLine(line) {
  List<FlSpot> coords = [];
  for (var coord in line) {
    double xYear = transformYearStringToIntXcoord(coord[0]);
    coords.add(FlSpot(xYear, coord[1]));
  }
  print("essas são as coordenadas da linha: $coords");
  return coords;
}
