import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';
import 'package:ft_dashboard/UI/SemesterChart.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';

class SemesterChartsCell extends StatelessWidget {
  const SemesterChartsCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const CellHeader(),
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

                  return Wrap(
                    children: charts,
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
  const CellHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Cursos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          // BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
          //     builder: (context, state) {
          //   List<String>? availableDates = state.availableDates;
          //   List<DropdownMenuEntry> menuOptions = state.availableDates!
          //       .map(
          //         (date) => DropdownMenuEntry(
          //           value: date,
          //           label: date,
          //         ),
          //       )
          //       .toList();
          //   String latestDate = "";
          //   if (availableDates != null) {
          //     latestDate = availableDates.last;
          //     print("latestDate: $latestDate");
          //   }
          //   return DropdownMenu(
          //     initialSelection: latestDate,
          //     //enableFilter: true,
          //     textStyle: const TextStyle(
          //       fontSize: 12,
          //     ),
          //     inputDecorationTheme: InputDecorationTheme(
          //       contentPadding: const EdgeInsets.symmetric(
          //         vertical: 0,
          //         horizontal: 10,
          //       ),
          //       constraints: const BoxConstraints(maxHeight: 35),
          //       isDense: true,
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     onSelected: (value) {
          //       print("mudei: $value");
          //       context
          //           .read<GeneralStatusBloc>()
          //           .add(GeneralStatusChangedTime());
          //     },
          //     dropdownMenuEntries: menuOptions,
          //   );
          // }),
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
