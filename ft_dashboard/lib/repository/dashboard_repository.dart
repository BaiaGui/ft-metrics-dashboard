import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/provider/api_provider.dart';

class DashboardRepository {
  final DashboardDataProvider _dashboardProvider;
  DashboardRepository({DashboardDataProvider? dashboardProvider})
      : _dashboardProvider = dashboardProvider ?? DashboardDataProvider();

  Future<MainChartModel> getIndex() async {
    final mainChart = await _dashboardProvider.getIndex();
    return mainChart;
  }

  Future<SurveyOverviewModel> getSurveyOverview(year, semester) async {
    final surveyData =
        await _dashboardProvider.getSurveyOverview(year, semester);
    return surveyData;
  }

  Future<List<SemesterChartModel>> getSemesterCharts(year, semester) async {
    final semestersData =
        await _dashboardProvider.getAnswerProportions(year, semester);
    return semestersData;
  }

  Future<List<String>> getAvailableYears() async {
    final availableYears = await _dashboardProvider.getAvailableYears();
    return availableYears;
  }

/*Course data*/
  Future<MainChartModel> getCourseIndex(courseId) async {
    final mainChart = await _dashboardProvider.getCourseIndex(courseId);
    return mainChart;
  }

  Future<SurveyOverviewModel> getCourseSurveyOverview(
      year, semester, courseId) async {
    final surveyData = await _dashboardProvider.getCourseSurveyOverview(
        year, semester, courseId);
    return surveyData;
  }

  Future<List<SemesterChartModel>> getCourseGroupsCharts(
      year, semester, courseId) async {
    final groupsData = await _dashboardProvider.getGroupsAnswerProportions(
        year, semester, courseId);
    return groupsData;
  }
}
