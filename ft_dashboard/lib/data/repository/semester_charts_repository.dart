import 'dart:async';

import 'package:ft_dashboard/data/provider/cohort_provider.dart';
import 'package:ft_dashboard/data/provider/course_provider.dart';
import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';

class SemesterChartsRepository {
  final CourseProvider courseProvider = CourseProvider();
  final CohortProvider cohortProvider = CohortProvider();
  final FormProvider formProvider = FormProvider();

  //retornar lista de models para cada curso que tem:
  // - lista com [6] valores,
  // - nome do curso,
  getSemesterChartsData({required int year, required int semester}) async {
    final allCourses = await courseProvider.getAllCoursesData();
    List chartsData = [];
    for (var course in allCourses) {
      var courseValues = getCourseFormData(course.id, year, semester);
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

  getCourseFormData(courseId, year, semester) async {
    List<Cohort> cohorts =
        await cohortProvider.getCohortsByTime(year, semester);
    print(cohorts);
    // var allCourses = await courseProvider.getAllCoursesData();
    //   cohorts = cohorts.where((cohort) => cohort.subjectCod )
  }
}
