import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/subject_class.dart';

const pathToFile = '../../../assets/turmas.json';

class SubjectClassProvider {
  Future<List<SubjectClass>> getSubjectClassData() async {
    List<dynamic> jsonData = await retrieveJson();
    return dynamicToModel(jsonData);
  }

  getSubjectClassbyCourseId(String CourseId) {}

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

  List<SubjectClass> dynamicToModel(List<dynamic> jsonArray) {
    List<SubjectClass> modelList =
        jsonArray.map((item) => SubjectClass.fromJson(item)).toList();
    return modelList;
  }
}
