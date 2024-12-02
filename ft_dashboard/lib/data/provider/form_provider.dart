import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/form.dart';

const pathToJsonFile = '../../../assets/formulario.json';

class FormProvider {
  Future<List<Form>> getFormsByGroupOfCohorts(cohorts) async {
    try {
      List<Form> filteredForms = [];

      for (var cohort in cohorts) {
        print("forms para turma  ${cohort.year} ${cohort.semester} ");
        var forms = await getFormByCohortId(cohort.code);
        filteredForms.addAll(forms);
      }
      return filteredForms;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<List<Form>> getFormData() async {
    try {
      List<dynamic> jsonData = await _retrieveJson();
      return _dynamicToModel(jsonData);
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<List<Form>> getFormByCohortId(String cohortId) async {
    try {
      List<Form> allForms = await getFormData();

      var filteredList =
          allForms.where((form) => form.cohortCod == cohortId).toList();

      return filteredList;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _retrieveJson() async {
    try {
      String jsonString = await rootBundle.loadString(pathToJsonFile);
      List<dynamic> jsonData = jsonDecode(jsonString);

      return jsonData;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  List<Form> _dynamicToModel(List<dynamic> jsonArray) {
    try {
      List<Form> modelList =
          jsonArray.map((item) => Form.fromJson(item)).toList();
      return modelList;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }
}
