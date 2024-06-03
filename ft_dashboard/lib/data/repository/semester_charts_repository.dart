import 'dart:async';

import 'package:ft_dashboard/data/provider/course_provider.dart';

class SemesterChartsRepository {
  final CourseProvider courseProvider = CourseProvider();

  //retornar lista de models para cada curso que tem:
  // - lista com [6] valores,
  // - nome do curso,
  getSemesterChartsData({required int year, required int semester}) async {
    final allCourses = await courseProvider.getAllCoursesData();
    List chartsData = [];
    for (var course in allCourses) {
      var courseValues = getCourseFormData(course.id);
      chartsData.add([course.name, courseValues]);
    }
    return chartsData;
  }

  //Função que dado um curso Id, ano e semestre
  //retorna proporção de respostas do curso e período
  //- pegar todos as turmas do período
  //- Filtrar turma pelo curso
  //- pegar todos os forms de cada turma
  //- calcular proporção de resposta de todos os forms
  //- Armazenar em uma list

  getCourseFormData(id) {}
}
