import 'package:dio/dio.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

class DashboardDataProvider {
  static DashboardDataProvider provider =
      DashboardDataProvider._createInstance();
  DashboardDataProvider._createInstance();

  final Dio _dio = Dio();
  String baseURL = "https://dashboard-api-zocb.onrender.com";

  Future<MainChartModel> getIndex(year, semester) async {
    try {
      Response response = await _dio
          .get("$baseURL/dashboard/indexes?year=$year&semester=$semester");
      return MainChartModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Index request error: $e');
    }
  }

  Future<SurveyOverviewModel> getSurveyOverview(year, semester) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/surveyOverview?year=$year&semester=$semester");
      return SurveyOverviewModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Index request error: $e');
    }
  }

  Future<List<SemesterChartModel>> getAnswerProportions(year, semester) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/answerProportion?year=$year&semester=$semester");
      return SemesterChartModel.fromList(response.data);
    } catch (e) {
      throw Exception('\n\n\nIndex request error: $e\n\n\n');
    }
  }
}
