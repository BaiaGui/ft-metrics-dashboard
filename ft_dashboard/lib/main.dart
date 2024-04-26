import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        SideBar(),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
              backgroundColor: Colors.purple[50],
              actions: [
                TextButton(onPressed: () {}, child: Icon(Icons.more_vert))
              ],
            ),
            body: Container(
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Container(
          alignment: Alignment.center,
          height: 60,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Avaliação das Disciplinas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 55.0,
          child: InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Icon(Icons.star),
                  SizedBox(width: 10),
                  Text("Botão"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
