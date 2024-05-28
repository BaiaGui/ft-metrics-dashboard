import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/form.dart';

const pathToFile = '../../../assets/formulario.json';

class FormProvider {
  Future<List<Form>> getFormsByGroupOfCohorts(cohorts) async {
    List<Form> filteredForms = [];

    for (var cohort in cohorts) {
      print("forms para turma  ${cohort.year} ${cohort.semester} ");
      var forms = await getFormByCohortId(cohort.code);
      filteredForms.addAll(forms);
    }
    return filteredForms;
  }

  Future<List<Form>> getFormData() async {
    List<dynamic> jsonData = await retrieveJson();
    return dynamicToModel(jsonData);
  }

  Future<List<Form>> getFormByCohortId(String cohortId) async {
    List<dynamic> jsonData = await retrieveJson();

    var filteredList =
        jsonData.where((form) => form['codTurma'] == cohortId).toList();

    //print("filtrei pelo id:$cohortId resultado:$filteredList");
    return dynamicToModel(filteredList);
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

  List<Form> dynamicToModel(List<dynamic> jsonArray) {
    List<Form> modelList =
        jsonArray.map((item) => Form.fromJson(item)).toList();
    return modelList;
  }
}
