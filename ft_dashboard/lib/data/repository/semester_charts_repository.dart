import 'dart:async';

import 'package:ft_dashboard/data/provider/cohort_provider.dart';
import 'package:ft_dashboard/data/provider/course_provider.dart';
import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';
import 'package:ft_dashboard/data/provider/models/course.dart';

class SemesterChartsRepository {
  final CourseProvider courseProvider = CourseProvider();
  final CohortProvider cohortProvider = CohortProvider();
  final FormProvider formProvider = FormProvider();

  //Função que retorna os dados da pesquisa mais recente (semestre do curso)
  getLatestSemesterData() async {
    List<int> latestDate = await _findLatestDate();
    return getSemesterChartsData(year: latestDate[0], semester: latestDate[1]);
  }

  Future<List<int>> _findLatestDate() async {
    Set<String> uniqueYears = {};
    final cohorts = await cohortProvider.getCohortData();
    for (var cohort in cohorts) {
      uniqueYears.add("${cohort.year}.${cohort.semester}");
    }
    print(uniqueYears.last);
    var latestDate = uniqueYears.last;
    var date = latestDate.split('.');
    print(date);
    return [int.parse(latestDate[0]), int.parse(latestDate[1])];
  }

  //retornar lista de models para cada curso que tem:
  // - lista com [6] valores,
  // - nome do curso,
  getSemesterChartsData({required int year, required int semester}) async {
    final allCourses = await courseProvider.getAllCoursesData();
    List chartsData = [];
    for (var course in allCourses) {
      var courseValues = await _getCourseFormData(course, year, semester);
      chartsData.add([course.name, courseValues]);
    }
    print(chartsData);
    return chartsData;
  }

  //Função que dado um curso Id, ano e semestre
  //retorna proporção de respostas do curso e período
  //- [x] pegar todos as turmas do período
  //- [x] Filtrar turma pelo curso
  //- [x] pegar todos os forms de cada turma
  //- [x] calcular proporção de resposta de todos os forms
  //- [x] Armazenar em uma list

  _getCourseFormData(Course course, int year, int semester) async {
    try {
      List<Cohort> cohorts =
          await cohortProvider.getCohortsByTime(year, semester);

      var courseCohorts = cohorts
          .where((cohort) => course.subjects.contains(cohort.subjectCod))
          .toList();
      print(
          "número de turmas para o curso ${course.name} em $year.$semester: ${courseCohorts.length}");
      var courseForms =
          await formProvider.getFormsByGroupOfCohorts(courseCohorts);

      List<double> proportion = [0, 0, 0, 0, 0, 0];
      courseForms.forEach((form) {
        for (var i = 0; i < proportion.length; i++) {
          proportion[i] += form.numberOfAnswersByType(i);
        }
      });
      print(
          "proporção de respostas do curso ${course.name} em $year.$semester: $proportion");
      return proportion;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }
}
