import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_dashboard/UI/SemesterChart.dart';

class SemesterChartsCell extends StatelessWidget {
  const SemesterChartsCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              CellHeader(),
              Expanded(
                child: Container(
                  //color: Colors.grey[50],
                  child: const Row(
                    children: [
                      Expanded(
                        child: SemesterChart(),
                      ),
                      Expanded(
                        child: SemesterChart(),
                      ),
                      Expanded(
                        child: SemesterChart(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CellHeader extends StatelessWidget {
  const CellHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Cursos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          DropdownMenu(
            enableFilter: true,
            textStyle: const TextStyle(
              fontSize: 12,
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              constraints: BoxConstraints(maxHeight: 35),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            dropdownMenuEntries: [
              const DropdownMenuEntry(
                value: "2024.1",
                label: "1° Semestre/2024",
              ),
              const DropdownMenuEntry(
                value: "2024.1",
                label: "2° Semestre/2024",
              ),
              const DropdownMenuEntry(
                value: "2024.1",
                label: "1° Semestre/2023",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
