import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/Bloc/main_chart_bloc.dart';

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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BlocBuilder<MainChartBloc, MainChartState>(
            builder: (context, state) {
              final data = state.surveyInfo;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Pesquisa mais recente",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  InfoCell(
                    mainInfo: "${data?.respondents}/${data?.totalEnrollments}",
                    infoDescription: "Respondentes/Total",
                    icon: Icons.people,
                  ),
                  Divider(),
                  InfoCell(
                    mainInfo: "${data?.surveyParticipation}%",
                    infoDescription: "Participação na Pesquisa",
                    icon: Icons.search,
                  ),
                  Divider(),
                  InfoCell(
                    mainInfo: "${data?.performanceIndex}",
                    infoDescription: "Índice Geral",
                    icon: Icons.stars,
                  ),
                ],
              );
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
