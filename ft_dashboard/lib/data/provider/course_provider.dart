import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/course.dart';

final pathToFile = "../../../assets/cursos.json";

class CourseProvider {
  Future<List<Course>> getAllCoursesData() async {
    List<dynamic> jsonData = await _retrieveJson();
    return _dynamicToModel(jsonData);
  }

  Future<Course> getCourseById(courseId) async {
    var allCourses = await getAllCoursesData();
    int index = allCourses.indexWhere((course) => course.id == courseId);
    return allCourses[index];
  }

  Future<List<dynamic>> _retrieveJson() async {
    try {
      String jsonString = await rootBundle.loadString(pathToFile);
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  _dynamicToModel(List<dynamic> jsonArray) {
    try {
      List<Course> modelList =
          jsonArray.map((item) => Course.fromJson(item)).toList();
      return modelList;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }
}
