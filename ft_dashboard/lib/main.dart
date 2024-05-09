import 'package:flutter/material.dart';
import 'package:ft_dashboard/SemesterChartsCell.dart';
import 'package:ft_dashboard/SideBar.dart';
import 'package:ft_dashboard/SurveyInfoCell.dart';
import 'package:ft_dashboard/UI/MainChartCell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardStructure(),
    );
  }
}

class DashboardStructure extends StatelessWidget {
  const DashboardStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SideBar(),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Dashboard"),
              backgroundColor: Colors.purple[50],
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Icon(Icons.more_vert),
                )
              ],
            ),
            body: SizedBox.expand(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35),
                color: Colors.grey[200],
                child: const Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          MainChartCell(),
                          SurveyInfoCell(),
                        ],
                      ),
                    ),
                    SemesterChartsCell(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
