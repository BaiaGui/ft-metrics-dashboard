import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/model/view_type.dart';

class GeneralStatusState {
  List<String>? availableDates = [];
  MainChartModel? mainChartData;
  SurveyOverviewModel? surveyData;
  List<SemesterChartModel>? semesterChartsData;
  ViewType currentView;

  String? selectedDate;
  String? dataId;
  // String? selectedCourseId;
  // String? selectedGroupId;
  // String? selectedSubjectId;

  GeneralStatusState(
      {this.mainChartData,
      this.surveyData,
      this.semesterChartsData,
      this.availableDates,
      this.selectedDate,
      this.dataId,
      required this.currentView});
}
