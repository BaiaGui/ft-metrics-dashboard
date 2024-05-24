import 'package:ft_dashboard/data/provider/cohort_provider.dart';
import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';
import 'package:ft_dashboard/data/utils.dart';

class MainChartRepository {
  final CohortProvider cohortProvider = CohortProvider();
  final FormProvider formProvider = FormProvider();

  Future<List<List<int>>> getLineAllData() async {
    var cohorts = await cohortProvider.getCohortData();
    Set<int> uniqueYears = findUniqueYears(cohorts);
    List<List<int>> linePoints = [];

    for (var year in uniqueYears) {
      var ySem1 = await getIndexByPeriodOfTime(
          cohorts: cohorts, year: year, semester: 1);
      var ySem2 = await getIndexByPeriodOfTime(
          cohorts: cohorts, year: year, semester: 2);

      int xYear = transformYearToXcoord(year);
      linePoints.add([xYear, ySem1]);
      linePoints.add([xYear + 1, ySem2]);
    }
    return linePoints;
  }

  Set<int> findUniqueYears(List<Cohort> cohorts) {
    Set<int> uniqueYears = {};
    for (var cohort in cohorts) {
      uniqueYears.add(cohort.year);
    }
    return (uniqueYears);
  }

  getIndexByPeriodOfTime(
      {required List<Cohort> cohorts,
      required int year,
      required int semester}) async {
    var filteredCohorts = filterCohortsBySemester(cohorts, semester);
    filteredCohorts = filterCohortsByYear(filteredCohorts, year);
    var forms = await formProvider.getFormsByGroupOfCohorts(filteredCohorts);
    var index = getIndexFromForms(forms);
    print("index para forms de turma $year $semester : $index");
    return index;
  }

  // filtros para as turmas: ano, semestre
  List<Cohort> filterCohortsByYear(List<Cohort> cohorts, year) {
    return cohorts.where((cohort) => cohort.year == year).toList();
  }

  List<Cohort> filterCohortsBySemester(List<Cohort> cohorts, semester) {
    return cohorts.where((cohort) => cohort.semester == semester).toList();
  }
}
