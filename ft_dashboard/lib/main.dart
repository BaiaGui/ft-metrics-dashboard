import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ft_dashboard/UI/SemesterChartsCell.dart';
import 'package:ft_dashboard/UI/SideBar.dart';
import 'package:ft_dashboard/UI/SurveyInfoCell.dart';
import 'package:ft_dashboard/UI/Header.dart';
import 'package:ft_dashboard/UI/MainChartCell.dart';
import 'package:ft_dashboard/data/provider/api_provider.dart';

void main() async {
  //runApp(const MyApp());
  runApp(const Placeholder());
  print(await DashboardDataProvider.provider.getIndex(2022, 2));
  var array =
      await DashboardDataProvider.provider.getAnswerProportions(2022, 2);
  print(array[0].course);
  print(array[0].propType0);
  print(await DashboardDataProvider.provider.getSurveyOverview(2022, 2));
  //var repo = SemesterChartsRepository();
  //await repo.getLatestSemesterData();
  //var subject = await getFormData();
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Dashboard',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const DashboardStructure(),
//     );
//   }
// }

// class TemporaryEmptyWidget extends StatelessWidget {
//   const TemporaryEmptyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class DashboardStructure extends StatelessWidget {
//   const DashboardStructure({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           const SideBar(),
//           Expanded(
//             flex: 5, //Proporção sidebar/dashboard (1/5)
//             child: Container(
//               color: Colors.grey[200],
//               child: Column(
//                 children: [
//                   const Header(),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 15.0, horizontal: 30),
//                       child: BlocProvider(
//                         create: (context) =>
//                             GeneralStatusBloc()..add(GeneralStatusStarted()),
//                         child: const Column(
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Row(
//                                 children: [
//                                   MainChartCell(),
//                                   SurveyInfoCell(),
//                                 ],
//                               ),
//                             ),
//                             SemesterChartsCell(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
