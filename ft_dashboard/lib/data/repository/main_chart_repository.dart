import 'package:ft_dashboard/data/provider/cohort_provider.dart';
import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';
import 'package:ft_dashboard/data/provider/models/form.dart';
import 'package:ft_dashboard/data/utils.dart';

class MainChartRepository {
  final CohortProvider cohortProvider = CohortProvider();
  final FormProvider formProvider = FormProvider();

  getChartLine() async {
    //recuperar lista com todos os anos que existem na base
    var cohorts = await cohortProvider.getCohortData();
    Set<int> uniqueYears = {};
    var linePoints = [];
    for (var cohort in cohorts) {
      uniqueYears.add(cohort.year);
    }
    print(uniqueYears);
    //para cada item da lista calcular o index semestre 1 e 2
    for (var year in uniqueYears) {
      var iSemester1 = await getIndexByPeriodOfTime(
          cohorts: cohorts, year: year, semester: 1);
      var iSemester2 = await getIndexByPeriodOfTime(
          cohorts: cohorts, year: year, semester: 2);
      //para cada iteração retornar uma lista [ano_num, index]
      int xCoord = yearToXcoord(year);
      linePoints.add([xCoord, iSemester1]);
      linePoints.add([xCoord + 1, iSemester2]);
    }
    print(linePoints);
  }

  getIndexByPeriodOfTime(
      {required List<Cohort> cohorts,
      required int year,
      required int semester}) async {
    var filteredCohorts = filterCohortsBySemester(cohorts, semester);
    filteredCohorts = filterCohortsByYear(filteredCohorts, year);
    var forms = await getFormsByGroupOfCohorts(filteredCohorts);
    var index = getIndexFromForms(forms);
    print("index para forms de turma $year $semester : $index");
    return index;
  }

  Future<List<Form>> getFormsByGroupOfCohorts(List<Cohort> group) async {
    List<Form> filteredForms = [];

    for (var cohort in group) {
      print("forms para turma  ${cohort.year} ${cohort.semester} ");

      var forms = await formProvider.getFormByCohortId(cohort.code);
      filteredForms.addAll(forms);
    }
    return filteredForms;
  }

  //3 filtros para as turmas: ano, semestre e curso
  List<Cohort> filterCohortsByYear(List<Cohort> cohorts, year) {
    return cohorts.where((cohort) => cohort.year == year).toList();
  }

  List<Cohort> filterCohortsBySemester(List<Cohort> cohorts, semester) {
    return cohorts.where((cohort) => cohort.semester == semester).toList();
  }
}
