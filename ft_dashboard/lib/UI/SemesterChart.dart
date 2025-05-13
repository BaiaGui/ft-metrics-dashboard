import 'dart:js_util';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/events/general_status_event.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';

class SemesterChart extends StatelessWidget {
  final String dataTime;
  final String dataSourceId;
  final String name;
  final List<double> values;

  SemesterChart({
    super.key,
    required this.dataSourceId,
    required this.dataTime,
    required this.name,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    var isClickable = values.toString() != [0, 0, 0, 0, 0, 0].toString();

    List<BarChartGroupData> chartBars = [];

    for (var i = 0; i < values.length; i++) {
      var bar = BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: values[i],
            width: 42,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
      chartBars.add(bar);
    }

    return InkWell(
      onTap: isClickable
          ? () {
              context.read<GeneralStatusBloc>().add(ChartClicked(
                  dataTime: dataTime,
                  dataSourceId: dataSourceId,
                  dataSourceName: name));
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Container(
          width: 400,
          height: 400,
          child: BarChart(
            BarChartData(
              borderData:
                  FlBorderData(border: Border.all(color: Colors.grey[300]!)),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  axisNameSize: 40,
                  axisNameWidget: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sideTitles: const SideTitles(
                    reservedSize: 300,
                  ),
                ),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomTitles,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 50),
                ),
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
              barGroups: chartBars,
            ),
          ),
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
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
    );
  }
}
