import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/subject_class.dart';

const pathToSubjectClass = '../../../assets/turmas.json';
const pathToCourse = '../../../assets/cursos.json';

class SubjectClassProvider {
  Future<List<SubjectClass>> getSubjectClassData() async {
    List<dynamic> jsonData = await retrieveJson(pathToSubjectClass);
    return dynamicToModel(jsonData);
  }

  getSubjectClassbyCourseId(String courseId) async {
    final courses = await retrieveJson(pathToCourse);
    final rightCourse =
        courses.where((course) => course['_id'] == courseId).toList();
    final courseSubjectList = rightCourse[0]['cod_disciplinas'];

    final subjectClass = await retrieveJson(pathToSubjectClass);
    var filteredSubjectClassList = [];
    for (var cl in subjectClass) {
      if (courseSubjectList.contains(cl['codDisc'])) {
        filteredSubjectClassList.add(cl);
      }
    }

    return dynamicToModel(filteredSubjectClassList);
  }

  Future<List<dynamic>> retrieveJson(String pathToFile) async {
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
