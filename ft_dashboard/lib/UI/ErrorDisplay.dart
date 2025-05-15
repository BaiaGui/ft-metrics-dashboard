import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.red),
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$errorMessage",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red[900]),
      ),
    );
  }
}
