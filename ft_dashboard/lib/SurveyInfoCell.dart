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
          padding: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              InfoCell(mainInfo: "25/30", infoDescription: "respondentes"),
              Divider(),
              InfoCell(mainInfo: "25/30", infoDescription: "respondentes"),
              Divider(),
              InfoCell(mainInfo: "25/30", infoDescription: "respondentes"),
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

  const InfoCell(
      {super.key, required this.mainInfo, required this.infoDescription});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.amber,
        //padding: EdgeInsets.only(left: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(infoDescription),
            Text(
              mainInfo,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
