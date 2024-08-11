import 'package:ft_dashboard/data/provider/cohort_provider.dart';
import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';
import 'package:ft_dashboard/data/utils.dart';

class MainChartRepository {
  final CohortProvider cohortProvider = CohortProvider();
  final FormProvider formProvider = FormProvider();

  Future<List<List<double>>> getChartLineByFormCategory(int category) async {
    var cohorts = await cohortProvider.getCohortData();
    Set<int> uniqueYears = findUniqueYears(cohorts);

    List<List<double>> linePoints = [];

    for (var year in uniqueYears) {
      var yearCoords = await getCoordsByYear(cohorts, year, category);
      linePoints = [...linePoints, ...yearCoords];
    }

    return linePoints;
  }

  Future<List<List<double>>> getCoordsByYear(cohorts, year, category) async {
    List<List<double>> yearCoords = [];
    var indexSem1 = await getIndexByPeriodOfTime(cohorts, year, 1, category);

    var indexSem2 = await getIndexByPeriodOfTime(cohorts, year, 2, category);

    double xYear = transformYearToXcoord(year);

    if (indexSem1 >= 0) {
      indexSem1 = double.parse(indexSem1.toStringAsFixed(2));
      yearCoords.add([xYear, indexSem1]);
    }
    if (indexSem2 >= 0) {
      indexSem2 = double.parse(indexSem2.toStringAsFixed(2));
      yearCoords.add([xYear + 1, indexSem2]);
    }
    return yearCoords;
  }

  Set<int> findUniqueYears(List<Cohort> cohorts) {
    Set<int> uniqueYears = {};
    for (var cohort in cohorts) {
      uniqueYears.add(cohort.year);
    }
    return (uniqueYears);
  }

  //1) transformar essa função em uma função que só filtra as tumas com base nos parametros (ano, semestre, ...)
  getIndexByPeriodOfTime(
      List<Cohort> cohorts, int year, int semester, category) async {
    var filteredCohorts = filterCohortsBySemester(cohorts, semester);
    filteredCohorts = filterCohortsByYear(filteredCohorts, year);
    var forms = await formProvider.getFormsByGroupOfCohorts(filteredCohorts);
    //filtrar forms por categoria
    var index = getIndexByQuestionCategory(forms, category);
    print(
        "index para forms de turma $year $semester e categoria $category : $index");

    return index;
  }

  // filtros para as turmas: ano, semestre (funções intermediarias para a função 1)
  List<Cohort> filterCohortsByYear(List<Cohort> cohorts, year) {
    return cohorts.where((cohort) => cohort.year == year).toList();
  }

  List<Cohort> filterCohortsBySemester(List<Cohort> cohorts, semester) {
    return cohorts.where((cohort) => cohort.semester == semester).toList();
  }

  //2) Criar uma função que pega os forms de uma lista de turmas (vão vir filtrados) e calcula index

  //3) Função que calcula uma linha com base na categoria, curso, grupo de disciplinas, disciplinas (na falta de um filtro pega tudo do filtro anterior)
}






//Nova versão seria:
/**
 * 1 função que calcula o index dado uma lista de formulários (não se importa com filtros, só calcula)
 * 1 função que pega as listas filtradas com base nos argumentos desejados
 * 1 função que calcula uma linha, ou seja, calcula o index n vezes para cada semestre do banco de dados. 
 *  Ela deve ser generica para ser reutilizada para cada categoria ou index geral
 * 
 * 
 * 
 * 
 *  filtros que se deve ter na função de filtro:
 * - filtro por ano
 * - filtro por semestre
 * - filtro por categoria da questão (range de número da questão)
 * 
 * Depois...(tela 2)
 * - filtro por curso
 * - filtro por grupo de disciplina
 * - filtro por disciplina
 */
