import 'package:dio/dio.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

class DashboardDataProvider {
  final Dio _dio = Dio();
  //String baseURL = "https://dashboard-api-zocb.onrender.com";
  String baseURL = "http://localhost:3000";

  Future<MainChartModel> getIndexHistory(view, id) async {
    try {
      Response response =
          await _dio.get("$baseURL/dashboard/indexes/$view/$id");
      return MainChartModel.fromMap(response.data);
    } catch (e) {
      throw Exception(
          'Provider:: Error while fetching the indexes to $view view: $e');
    }
  }

  Future<SurveyOverviewModel> getSurveyOverview(
      view, id, year, semester) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/surveyOverview/$view/$id?year=$year&semester=$semester");
      return SurveyOverviewModel.fromMap(response.data);
    } catch (e) {
      throw Exception(
          'Provider:: Error while fetching the survey overview to $view view: $e');
    }
  }

  Future<List<SemesterChartModel>> getSemesterCharts(
      view, id, year, semester) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/answerProportion/$view/$id?year=$year&semester=$semester");
      return SemesterChartModel.fromList(response.data);
    } catch (e) {
      throw Exception(
          'Provider:: Error while fetching semester charts to $view view: $e');
    }
  }

//---------------------------------------------------------------------------------------------------
  Future<List<String>> getAvailableYears() async {
    try {
      Response response = await _dio.get("$baseURL/data/years");
      final responseMap = response.data;
      return (responseMap['uniqueYears'] as List).cast<String>();
    } catch (e) {
      throw Exception('Error fetching available years: $e');
    }
  }

//-----------------------------------------------------------------------------------------------------
  Future<List<List<String>>> getSubjectComments(
      year, semester, subjectId) async {
    try {
      Response response = await _dio.get(
          "$baseURL/dashboard/answerProportion/comments/$subjectId?year=$year&semester=$semester");
      List<dynamic> dynamic25 = response.data["question25"];
      List<dynamic> dynamic26 = response.data["question26"];
      List<String> comments25 = dynamic25.cast<String>();
      List<String> comments26 = dynamic26.cast<String>();

      return [comments25, comments26];
    } catch (e) {
      throw Exception(
          'Provider:: Error while fetching comments of the subject $subjectId: $e');
    }
  }
}
