import 'package:dio/dio.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

class DashboardDataProvider {
  final Dio _dio = Dio();
  //String baseURL = "https://dashboard-api-zocb.onrender.com";
  String baseURL = "http://localhost:3000";

  Future<MainChartModel> getIndexHistory(view) async {
    try {
      Response response = await _dio.get("$baseURL/dashboard/indexes/$view/0");
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

//   Future<MainChartModel> getIndex() async {
//     try {
//       Response response =
//           await _dio.get("$baseURL/dashboard/indexes/general/0");
//       return MainChartModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception(
//           'Provider:: Error while fetching the general indexes: $e');
//     }
//   }

//   Future<SurveyOverviewModel> getSurveyOverview(year, semester) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/surveyOverview/general/0?year=$year&semester=$semester");
//       return SurveyOverviewModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception(
//           'Provider:: Error while fetching the general survey overview: $e');
//     }
//   }

//   Future<List<SemesterChartModel>> getSemesterCharts(year, semester) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/answerProportion/general/0?year=$year&semester=$semester");
//       return SemesterChartModel.fromList(response.data);
//     } catch (e) {
//       throw Exception(
//           'Provider:: Error while fetching the course answer proportion charts: $e');
//     }
//   }

//   /*Course Vision Data*/

//   Future<MainChartModel> getCourseIndex(courseId) async {
//     try {
//       print("$baseURL/dashboard/indexes/course/$courseId");
//       Response response =
//           await _dio.get("$baseURL/dashboard/indexes/course/$courseId");

//       return MainChartModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception('Provider::Error while trying to fetch course index: $e');
//     }
//   }

//   Future<SurveyOverviewModel> getCourseSurveyOverview(
//       year, semester, courseId) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/surveyOverview/course/$courseId?year=$year&semester=$semester");
//       return SurveyOverviewModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception(
//           'Provider::Error while trying to fetch the course survey overview: $e');
//     }
//   }

//   Future<List<SemesterChartModel>> getGroupsAnswerProportions(
//       year, semester, courseId) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/answerProportion/course/$courseId?year=$year&semester=$semester");
//       print("ok");
//       return SemesterChartModel.fromList(response.data);
//     } catch (e) {
//       throw Exception(
//           'Provider::Error while trying to fetch the course awnser proportions: $e');
//     }
//   }

// /*Subject Group Vision Data*/

//   Future<MainChartModel> getGroupIndex(groupId) async {
//     try {
//       Response response =
//           await _dio.get("$baseURL/dashboard/indexes/$groupId/$groupId");

//       return MainChartModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception('Index request error: $e');
//     }
//   }

//   Future<SurveyOverviewModel> getGroupSurveyOverview(
//       year, semester, groupId) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/surveyOverview/$groupId/$groupId?year=$year&semester=$semester");
//       return SurveyOverviewModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception('Survey info request error: $e');
//     }
//   }

//   Future<List<SemesterChartModel>> getSubjectsAnswerProportions(
//       year, semester, groupId) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/answerProportion/$groupId/$groupId?year=$year&semester=$semester");
//       return SemesterChartModel.fromList(response.data);
//     } catch (e) {
//       throw Exception('\n\n\n Group data request error: $e\n\n\n');
//     }
//   }

// /*Subject Vision Data*/

//   Future<MainChartModel> getSubjectIndex(courseId) async {
//     try {
//       Response response =
//           await _dio.get("$baseURL/dashboard/indexes/$courseId");

//       return MainChartModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception('Index request error: $e');
//     }
//   }

//   Future<SurveyOverviewModel> getSubjectSurveyOverview(
//       year, semester, courseId) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/surveyOverview/$courseId?year=$year&semester=$semester");
//       return SurveyOverviewModel.fromMap(response.data);
//     } catch (e) {
//       throw Exception('Survey info request error: $e');
//     }
//   }

//   Future<List<SemesterChartModel>> getSubjectComments(
//       year, semester, courseId) async {
//     try {
//       Response response = await _dio.get(
//           "$baseURL/dashboard/answerProportion/$courseId?year=$year&semester=$semester");
//       return SemesterChartModel.fromList(response.data);
//     } catch (e) {
//       throw Exception('\n\n\n Group data request error: $e\n\n\n');
//     }
//   }
}
