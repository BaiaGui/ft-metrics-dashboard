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
        _dashboardProvider.getIndexHistory(view.name, dataId),
        _dashboardProvider.getSurveyOverview(view.name, dataId, year, semester),
        _dashboardProvider.getSemesterCharts(view.name, dataId, year, semester),
        _dashboardProvider.getAvailableYears(),
      ]);
      return allDashboardData;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<List<String>>> fetchCommentsBySubject(
      year, semester, subjectId) async {
    try {
      final commentsCollection = await _dashboardProvider.getSubjectComments(
          year, semester, subjectId);
      return commentsCollection;
    } catch (e) {
      rethrow;
    }
  }
}
