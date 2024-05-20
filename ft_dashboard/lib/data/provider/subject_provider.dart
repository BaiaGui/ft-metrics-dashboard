import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/subject.dart';

const pathToFile = '../../../assets/disciplina.json';

Future<List<Subject>> getSubjectJson() async {
  try {
    String jsonString = await rootBundle.loadString(pathToFile);
    List<dynamic> jsonData = jsonDecode(jsonString);
    return dynamicToModel(jsonData);
  } catch (e) {
    print("Error: $e");
    throw Exception('Failed to load subject');
  }
}

List<Subject> dynamicToModel(List<dynamic> jsonArray) {
  List<Subject> modelList =
      jsonArray.map((item) => Subject.fromJson(item)).toList();
  return modelList;
}
