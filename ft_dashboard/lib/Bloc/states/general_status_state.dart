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
  List<String>? comments25;
  List<String>? comments26;
  List<PathSegment> path;

  GeneralStatusState({
    this.mainChartData,
    this.surveyData,
    this.semesterChartsData,
    this.availableDates,
    this.selectedDate,
    this.dataId,
    this.comments25,
    this.comments26,
    required this.currentView,
    required this.path,
  });
}

class PathSegment {
  String id;
  ViewType view;
  String name;

  PathSegment(
      {this.id = "0", this.view = ViewType.general, this.name = "Geral"});
}
