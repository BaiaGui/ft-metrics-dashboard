import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';

class SurveyInfoCell extends StatelessWidget {
  const SurveyInfoCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          bottom: 10.0,
        ),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
            builder: (context, state) {
              final data = state.surveyData;
              var referenceDate = state.availableDates?.last;
              if (state.availableDates != null) {
                referenceDate =
                    state.selectedDate ?? state.availableDates?.last;
              }

              if (data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Informações da Pesquisa de $referenceDate",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    InfoCell(
                      mainInfo:
                          "${data?.totalRespondents}/${data?.totalEnrolled}",
                      infoDescription: "Respondentes/Total",
                      icon: Icons.people,
                    ),
                    const Divider(),
                    InfoCell(
                      mainInfo: "${data?.surveyParticipation}%",
                      infoDescription: "Participação na Pesquisa",
                      icon: Icons.search,
                    ),
                    const Divider(),
                    InfoCell(
                      mainInfo: "${data?.averageIndex}",
                      infoDescription: "Índice Geral",
                      icon: Icons.stars,
                    ),
                  ],
                );
              } else {
                return const ChartSkeletons();
              }
            },
          ),
        ),
      ),
    );
  }
}

class InfoCell extends StatelessWidget {
  final String mainInfo;
  final String infoDescription;
  final IconData icon;

  const InfoCell(
      {super.key,
      required this.mainInfo,
      required this.infoDescription,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.amber,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Icon(
                icon,
                size: 60,
                color: Colors.grey[200],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(infoDescription),
                Text(
                  mainInfo,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartSkeletons extends StatelessWidget {
  const ChartSkeletons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
    );
  }
}
