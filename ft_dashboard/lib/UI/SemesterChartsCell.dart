import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';
import 'package:ft_dashboard/UI/SemesterChart.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/view_type.dart';

class SemesterChartsCell extends StatelessWidget {
  const SemesterChartsCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
              builder: (context, state) {
                List<SemesterChartModel>? chartsData = state.semesterChartsData;
                if (chartsData != null && state.selectedDate != null) {
                  List<Widget> charts = [];
                  String date = state.selectedDate!;

                  charts = chartsData
                      .map(
                        (chartData) => SemesterChart(
                            dataTime: date,
                            dataSourceId: chartData.dataSourceId,
                            name: chartData.chartName,
                            values: chartData.proportions),
                      )
                      .toList();

                  return Column(
                    children: [
                      CellHeader(title: state.currentView.name),
                      Wrap(
                        children: charts,
                      ),
                    ],
                  );
                } else {
                  return const InfoSkeletons();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CellHeader extends StatelessWidget {
  const CellHeader({super.key, required this.title});

  final String title;

  String cellTitle(title) {
    switch (title) {
      case "general":
        return "Curso";
      case "course":
        return "Grupo de Matérias";
      case "subjectGroup":
        return "Matéria";
      case "subject":
        return "Questão ";
      default:
        return "Proporção de tipo de resposta";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Proporção de resposta por ${cellTitle(title)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoSkeletons extends StatelessWidget {
  const InfoSkeletons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 300,
              color: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 300,
              color: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 300,
              color: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }
}


// String defineModuleTitle(view){

// }