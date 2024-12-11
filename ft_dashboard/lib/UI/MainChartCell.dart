import 'package:flutter/material.dart';
import 'package:ft_dashboard/UI/MainChart.dart';

class MainChartCell extends StatelessWidget {
  const MainChartCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: Container(
          height: 500,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Evolução do Índice",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              //Espaço para o gráfico principal:
              Expanded(
                child: Container(
                  //color: Colors.grey[50],
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: MainChart(),
                ),
              ),
              ChartLegend(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              color: Colors.amber,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Infraestrutura e Suporte às aulas")
          ],
        ),
        SizedBox(
          width: 25,
        ),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              color: Colors.green,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Participação do Estudante")
          ],
        ),
        SizedBox(
          width: 25,
        ),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              color: Colors.blue,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Atuação Docente"),
          ],
        )
      ],
    );
  }
}
