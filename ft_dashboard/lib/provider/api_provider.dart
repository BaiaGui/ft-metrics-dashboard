import 'package:dio/dio.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

class DashboardDataProvider {
  // static DashboardDataProvider provider =
  //     DashboardDataProvider._createInstance();
  // DashboardDataProvider._createInstance();

  final Dio _dio = Dio();
  //String baseURL = "https://dashboard-api-zocb.onrender.com";
  String baseURL = "http://localhost:3000";

  Future<MainChartModel> getIndex() async {
    try {
      Response response = await _dio.get("$baseURL/dashboard/indexes");

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
      throw Exception('Survey info request error: $e');
    }
  }

  Future<List<SemesterChartModel>> getAnswerProportions(year, semester) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/answerProportion?year=$year&semester=$semester");
      return SemesterChartModel.fromList(response.data);
    } catch (e) {
      throw Exception('\n\n\n Semester data request error: $e\n\n\n');
    }
  }

  Future<List<String>> getAvailableYears() async {
    try {
      Response response = await _dio.get("$baseURL/data/years");
      final responseMap = response.data;
      return (responseMap['uniqueYears'] as List).cast<String>();
    } catch (e) {
      throw Exception('Error on getting available years: $e');
    }
  }

/*Course Vision Data*/

  Future<MainChartModel> getCourseIndex(courseId) async {
    try {
      Response response =
          await _dio.get("$baseURL/dashboard/indexes/$courseId");

      return MainChartModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Index request error: $e');
    }
  }

  Future<SurveyOverviewModel> getCourseSurveyOverview(
      year, semester, courseId) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/surveyOverview/$courseId?year=$year&semester=$semester");
      return SurveyOverviewModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Survey info request error: $e');
    }
  }

  Future<List<SemesterChartModel>> getGroupsAnswerProportions(
      year, semester, courseId) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/answerProportion/$courseId?year=$year&semester=$semester");
      return SemesterChartModel.fromList(response.data);
    } catch (e) {
      throw Exception('\n\n\n Group data request error: $e\n\n\n');
    }
  }
}
