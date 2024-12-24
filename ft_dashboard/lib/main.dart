import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';

import 'package:ft_dashboard/UI/SemesterChartsCell.dart';
import 'package:ft_dashboard/UI/SideBar.dart';
import 'package:ft_dashboard/UI/SurveyInfoCell.dart';
import 'package:ft_dashboard/UI/MainChartCell.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    return Scaffold(
      body: BlocProvider(
        create: (context) => GeneralStatusBloc()..add(GeneralStatusStarted()),
        child: const Row(
          children: [
            SideBar(),
            Expanded(
              flex: 5,
              child: DashboardContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DashboardHeader(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
            color: Colors.grey[200],
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 450,
                    child: Row(
                      children: [MainChartCell(), SurveyInfoCell()],
                    ),
                  ),
                  SemesterChartsCell(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 1,
            color: Colors.grey[100]!,
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          DashboardDropdown(),
        ],
      ),
    );
  }
}

class DashboardDropdown extends StatelessWidget {
  const DashboardDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
      builder: (context, state) {
        final availableDates = state.availableDates ?? [];
        final latestDate = availableDates.isNotEmpty ? availableDates.last : "";
        final selectedDate = state.referenceDate ?? latestDate;
        final menuOptions = availableDates
            .map((date) => DropdownMenuEntry(value: date, label: date))
            .toList();
        print("latest date: $selectedDate");

        return DropdownMenu(
          initialSelection: selectedDate,
          textStyle: const TextStyle(fontSize: 12),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            constraints: const BoxConstraints(maxHeight: 35),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onSelected: (value) {
            context
                .read<GeneralStatusBloc>()
                .add(GeneralStatusChangedTime(value));
          },
          dropdownMenuEntries: menuOptions,
        );
      },
    );
  }
}
