import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/model/view_type.dart';
import 'package:ft_dashboard/provider/api_provider.dart';

class DashboardRepository {
  final DashboardDataProvider _dashboardProvider;
  DashboardRepository({DashboardDataProvider? dashboardProvider})
      : _dashboardProvider = dashboardProvider ?? DashboardDataProvider();

  Future<List<Object>> getDashboardData(
      ViewType view, dataId, year, semester) async {
    try {
      final allDashboardData = await Future.wait([
        _dashboardProvider.getIndexHistory(view.name),
        _dashboardProvider.getSurveyOverview(view.name, dataId, year, semester),
        _dashboardProvider.getSemesterCharts(view.name, dataId, year, semester),
        _dashboardProvider.getAvailableYears(),
      ]);
      return allDashboardData;
    } catch (e) {
      rethrow;
    }
  }

/*TODO:
  Continue this logic below with every vision of the dashaboard.
  Then find a way of calling the corresponding function in the bloc layer based only on
  - the vision defined in the argument
  - the id of the vision
 */
  // Future<List<Object>> getGeneralData(year, semester) async {
  //   final allDashboardData = await Future.wait([
  //     _dashboardProvider.getIndex(),
  //     _dashboardProvider.getSurveyOverview(year, semester),
  //     _dashboardProvider.getSemesterCharts(year, semester),
  //     _dashboardProvider.getAvailableYears(),
  //   ]);
  //   return allDashboardData;
  // }

  // Future<List<Object>> getCourseData(year, semester, courseId) async {
  //   final allDashboardData = await Future.wait([
  //     _dashboardProvider.getCourseIndex(courseId),
  //     _dashboardProvider.getCourseSurveyOverview(year, semester, courseId),
  //     _dashboardProvider.getGroupsAnswerProportions(year, semester, courseId),
  //     _dashboardProvider.getAvailableYears(),
  //   ]);
  //   return allDashboardData;
  // }

  // Future<List<Object>> getSubjectGroupData(year, semester, groupId) async {
  //   final allDashboardData = await Future.wait([
  //     _dashboardProvider.getGroupIndex(groupId),
  //     _dashboardProvider.getGroupSurveyOverview(year, semester, groupId),
  //     _dashboardProvider.getSubjectsAnswerProportions(year, semester, groupId),
  //     _dashboardProvider.getAvailableYears(),
  //   ]);
  //   return allDashboardData;
  // }

  // Future<List<Object>> getSubjectData(year, semester, subjectId) async {
  //   final allDashboardData = await Future.wait([
  //     _dashboardProvider.getSubjectIndex(subjectId),
  //     _dashboardProvider.getSubjectSurveyOverview(year, semester, subjectId),
  //     _dashboardProvider.getSubjectComments(year, semester, subjectId),
  //     _dashboardProvider.getAvailableYears(),
  //   ]);
  //   return allDashboardData;
  // }

//   Future<MainChartModel> getIndex() async {
//     final mainChart = await _dashboardProvider.getIndex();
//     return mainChart;
//   }

//   Future<SurveyOverviewModel> getSurveyOverview(year, semester) async {
//     final surveyData =
//         await _dashboardProvider.getSurveyOverview(year, semester);
//     return surveyData;
//   }

//   Future<List<SemesterChartModel>> getSemesterCharts(year, semester) async {
//     final semestersData =
//         await _dashboardProvider.getAnswerProportions(year, semester);
//     return semestersData;
//   }

//   Future<List<String>> getAvailableYears() async {
//     final availableYears = await _dashboardProvider.getAvailableYears();
//     return availableYears;
//   }

// /*Course data*/
//   Future<MainChartModel> getCourseIndex(courseId) async {
//     final mainChart = await _dashboardProvider.getCourseIndex(courseId);
//     return mainChart;
//   }

//   Future<SurveyOverviewModel> getCourseSurveyOverview(
//       year, semester, courseId) async {
//     final surveyData = await _dashboardProvider.getCourseSurveyOverview(
//         year, semester, courseId);
//     return surveyData;
//   }

//   Future<List<SemesterChartModel>> getCourseGroupsCharts(
//       year, semester, courseId) async {
//     final groupsData = await _dashboardProvider.getGroupsAnswerProportions(
//         year, semester, courseId);
//     return groupsData;
//   }
}
