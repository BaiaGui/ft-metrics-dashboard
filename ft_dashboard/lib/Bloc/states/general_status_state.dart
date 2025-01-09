import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

class GeneralStatusState {
  List<String>? availableDates = [];
  MainChartModel? mainChartData;
  SurveyOverviewModel? surveyData;
  List<SemesterChartModel>? semesterChartsData;
  String? selectedDate;

  GeneralStatusState(
      {this.mainChartData,
      this.surveyData,
      this.semesterChartsData,
      this.availableDates,
      this.selectedDate});
}
