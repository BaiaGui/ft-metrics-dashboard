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
      // dynamic responseData = {
      //   "indexInfra": [
      //     ["2022.2", 0.85],
      //     ["2023.1", 0.85],
      //     ["2023.2", 0.85],
      //   ],
      //   "indexStudent": [
      //     ["2022.2", 0.75],
      //     ["2023.1", 0.75],
      //     ["2023.2", 0.75],
      //   ],
      //   "indexTeacher": [
      //     ["2022.2", 0.65],
      //     ["2023.1", 0.65],
      //     ["2023.2", 0.65],
      //   ],
      // };
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
}
