import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/model/view_type.dart';

class GeneralStatusState {
  List<String>? availableDates = [];
  String? selectedDate;

  MainChartModel? mainChartData;
  SurveyOverviewModel? surveyData;
  List<SemesterChartModel>? semesterChartsData;

  String? dataId;
  List<String>? comments25;
  List<String>? comments26;

  ViewType currentView;
  List<PathSegment> path;

  String? errorMessage;

  GeneralStatusState(
      {this.mainChartData,
      this.surveyData,
      this.semesterChartsData,
      this.availableDates,
      this.selectedDate,
      this.dataId,
      this.comments25,
      this.comments26,
      this.errorMessage,
      this.currentView = ViewType.loading,
      List<PathSegment>? path})
      : path = path ?? [PathSegment()];
}

class PathSegment {
  String id;
  ViewType view;
  String name;

  PathSegment(
      {this.id = "0", this.view = ViewType.general, this.name = "Geral"});
}
