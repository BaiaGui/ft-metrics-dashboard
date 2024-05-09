import 'package:flutter/material.dart';

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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cursos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  DropdownMenu(
                    textStyle: TextStyle(
                      fontSize: 12,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          value: "Arroz", label: "1° Semestre/2024"),
                    ],
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                color: Colors.grey[50],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
