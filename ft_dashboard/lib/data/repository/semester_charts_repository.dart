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
  getLatestCourseProportionCharts() async {
    List<int> latestDate = await _findLatestDate();
    return getCoursesProportionChartsByTime(
        year: latestDate[0], semester: latestDate[1]);
  }

  Future<List<int>> _findLatestDate() async {
    final availableDates = await findAvailableDates();
    print(availableDates.last);
    var latestDate = availableDates.last;
    var date = latestDate.split('.');
    print(date);
    final year = int.parse(date[0]);
    final semester = int.parse(date[1]);
    return [year, semester];
  }

  Future<Set<String>> findAvailableDates() async {
    Set<String> availableDates = {};
    final cohorts = await cohortProvider.getCohortData();
    for (var cohort in cohorts) {
      availableDates.add("${cohort.year}.${cohort.semester}");
    }
    print("available dates: $availableDates");
    return availableDates;
  }

  //(Main function) retornar lista de models para cada curso que tem:
  // - lista com [6] valores,
  // - nome do curso,
  Future<List> getCoursesProportionChartsByTime(
      {required int year, required int semester}) async {
    final allCourses = await courseProvider.getAllCoursesData();
    List chartsData = [];
    for (var course in allCourses) {
      var courseValues =
          await _getCourseAnswerProportionByTime(course, year, semester);
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

  Future<List<double>> _getCourseAnswerProportionByTime(
      Course course, int year, int semester) async {
    try {
      var courseForms = await _getCourseForms(course, year, semester);

      List<double> proportion = [0, 0, 0, 0, 0, 0];
      courseForms.forEach((form) {
        for (var i = 0; i < proportion.length; i++) {
          proportion[i] += form.answerTypeQuantity(i);
        }
      });

      print(
          "proporção de respostas do curso ${course.name} em $year.$semester: $proportion");

      return proportion;
    } catch (e) {
      print("SemesterChartsRepository: $e");
      throw Exception('Failed to get course answer proportion');
    }
  }

  _getCourseForms(course, year, semester) async {
    List<Cohort> cohorts =
        await cohortProvider.getCohortsByTime(year, semester);

    var courseCohorts = cohorts
        .where((cohort) => course.subjects.contains(cohort.subjectCod))
        .toList();
    //print(
    //"número de turmas para o curso ${course.name} em $year.$semester: ${courseCohorts.length}");
    var courseForms =
        await formProvider.getFormsByGroupOfCohorts(courseCohorts);
    return courseForms;
  }
}
