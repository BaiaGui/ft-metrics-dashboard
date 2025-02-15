import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/provider/api_provider.dart';

class DashboardRepository {
  final DashboardDataProvider _dashboardProvider;
  DashboardRepository({DashboardDataProvider? dashboardProvider})
      : _dashboardProvider = dashboardProvider ?? DashboardDataProvider();

//TODO: Change arguments of the functions to match endpoints
  Future<List<Object>> getDashboardData(year, semester,
      [courseId, groupId, subjectId]) async {
    try {
      if (year != null &&
          semester != null &&
          courseId != null &&
          groupId != null &&
          subjectId != null) {
        final allDashboardData = await Future.wait([
          _dashboardProvider.getSubjectIndex(subjectId),
          _dashboardProvider.getSubjectSurveyOverview(
              year, semester, subjectId),
          _dashboardProvider.getSubjectComments(year, semester, subjectId),
          _dashboardProvider.getAvailableYears(),
        ]);
        return allDashboardData;
      } else if (year != null &&
          semester != null &&
          courseId != null &&
          groupId != null) {
        final allDashboardData = await Future.wait([
          _dashboardProvider.getGroupIndex(groupId),
          _dashboardProvider.getGroupSurveyOverview(year, semester, groupId),
          _dashboardProvider.getSubjectsAnswerProportions(
              year, semester, groupId),
          _dashboardProvider.getAvailableYears(),
        ]);
        return allDashboardData;
      } else if (year != null && semester != null && courseId != null) {
        final allDashboardData = await Future.wait([
          _dashboardProvider.getCourseIndex(courseId),
          _dashboardProvider.getCourseSurveyOverview(year, semester, courseId),
          _dashboardProvider.getGroupsAnswerProportions(
              year, semester, courseId),
          _dashboardProvider.getAvailableYears(),
        ]);
        return allDashboardData;
      } else if (year != null && semester != null) {
        final allDashboardData = await Future.wait([
          _dashboardProvider.getIndex(),
          _dashboardProvider.getSurveyOverview(year, semester),
          _dashboardProvider.getSemesterCharts(year, semester),
          _dashboardProvider.getAvailableYears(),
        ]);
        return allDashboardData;
      } else {
        throw Exception('Invalid arguments');
      }
    } catch (e) {
      print('\n\n\n\nERRO NO REPOSITORY: $e\n\n\n\n');
      throw Exception('Error fetching dashboard data: $e');
    }
  }

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
