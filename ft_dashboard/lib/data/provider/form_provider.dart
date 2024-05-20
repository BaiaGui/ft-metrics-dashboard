import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ft_dashboard/data/provider/models/form.dart';

const pathToFile = '../../../assets/formulario.json';

class FormProvider {
  Future<List<Form>> getFormData() async {
    try {
      String jsonString = await rootBundle.loadString(pathToFile);
      List<dynamic> jsonData = jsonDecode(jsonString);

      return dynamicToModel(jsonData);
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
