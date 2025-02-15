import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

enum ViewType { general, course, subjectGroup, subject, loading, error }

class GeneralStatusState {
  List<String>? availableDates = [];
  MainChartModel? mainChartData;
  SurveyOverviewModel? surveyData;
  List<SemesterChartModel>? semesterChartsData;
  ViewType currentView;

  String? selectedDate;
  String? selectedCourseId;
  String? selectedGroupId;
  String? selectedSubjectId;

  GeneralStatusState(
      {this.mainChartData,
      this.surveyData,
      this.semesterChartsData,
      this.availableDates,
      this.selectedDate,
      this.selectedCourseId,
      this.selectedGroupId,
      this.selectedSubjectId,
      required this.currentView});
}
