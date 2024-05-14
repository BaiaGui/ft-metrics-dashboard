import 'package:flutter/material.dart';

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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCell(
                mainInfo: "25/30",
                infoDescription: "Respondentes/Total",
                icon: Icons.people,
              ),
              Divider(),
              InfoCell(
                mainInfo: "88,64%",
                infoDescription: "Participação na Pesquisa",
                icon: Icons.search,
              ),
              Divider(),
              InfoCell(
                mainInfo: "4,7",
                infoDescription: "Índice Geral",
                icon: Icons.stars,
              ),
            ],
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
