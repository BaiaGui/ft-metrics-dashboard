import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ft_dashboard/SideBar.dart';

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
                TextButton(onPressed: () {}, child: Icon(Icons.more_vert))
              ],
            ),
            body: SizedBox.expand(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        child: Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              InfoCell(
                                  mainInfo: "25/30",
                                  infoDescription: "respondentes"),
                              VerticalDivider(),
                              InfoCell(
                                  mainInfo: "25/30",
                                  infoDescription: "respondentes"),
                              VerticalDivider(),
                              InfoCell(
                                  mainInfo: "25/30",
                                  infoDescription: "respondentes"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
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

class InfoCell extends StatelessWidget {
  final String mainInfo;
  final String infoDescription;

  const InfoCell(
      {super.key, required this.mainInfo, required this.infoDescription});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.amber,
        padding: EdgeInsets.only(left: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainInfo,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(infoDescription),
          ],
        ),
      ),
    );
  }
}
