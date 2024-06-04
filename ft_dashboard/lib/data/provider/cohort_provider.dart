import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';

const pathToCohort = '../../../assets/turmas.json';

class CohortProvider {
  Future<List<Cohort>> getCohortData() async {
    List<dynamic> jsonData = await _retrieveJson(pathToCohort);
    return _dynamicToModel(jsonData);
  }

  // getCohortsByCourseId(String courseId) async {
  //   final courses = await retrieveJson(pathToCourse);
  //   final rightCourse =
  //       courses.where((course) => course['_id'] == courseId).toList();
  //   final courseSubjectList = rightCourse[0]['cod_disciplinas'];

  //   final cohorts = await retrieveJson(pathToCohort);
  //   var filteredCohortList = [];
  //   for (var value in cohorts) {
  //     if (courseSubjectList.contains(value['codDisc'])) {
  //       filteredCohortList.add(value);
  //     }
  //   }

  //   return dynamicToModel(filteredCohortList);
  // }

  Future<List<Cohort>> getCohortsByTime(int year, int semester) async {
    var allCohorts = await getCohortData();
    var filteredCohorts = allCohorts
        .where((cohort) => cohort.year == year && cohort.semester == semester)
        .toList();
    return filteredCohorts;
  }

  Future<List<dynamic>> _retrieveJson(String pathToFile) async {
    try {
      String jsonString = await rootBundle.loadString(pathToFile);
      List<dynamic> jsonData = jsonDecode(jsonString);

      return jsonData;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  List<Cohort> _dynamicToModel(List<dynamic> jsonArray) {
    List<Cohort> modelList =
        jsonArray.map((item) => Cohort.fromJson(item)).toList();
    return modelList;
  }
}
