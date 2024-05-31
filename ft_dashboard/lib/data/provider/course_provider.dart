import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/course.dart';

final pathToFile = "../../../assets/cursos.json";

class CourseProvider {
  Future<List<Course>> getAllCoursesData() async {
    List<dynamic> jsonData = await retrieveJson();
    return dynamicToModel(jsonData);
  }

  Future<List<dynamic>> retrieveJson() async {
    try {
      String jsonString = await rootBundle.loadString(pathToFile);
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  dynamicToModel(List<dynamic> jsonArray) {
    List<Course> modelList =
        jsonArray.map((item) => Course.fromJson(item)).toList();
    return modelList;
  }
}
