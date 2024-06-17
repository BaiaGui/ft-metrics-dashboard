import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/main_chart_repository.dart';
import 'package:ft_dashboard/data/repository/models/survey_info.dart';
import 'package:ft_dashboard/data/repository/semester_charts_repository.dart';
import 'package:ft_dashboard/data/repository/survey_info_repository.dart';

class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusState {
  List<List<double>> mainChartLinePoints;
  SurveyInfo? surveyInfo;
  List semesterChartsData;
  Set<String> availableDates;

  GeneralStatusState(
      [this.mainChartLinePoints = const [],
      this.surveyInfo,
      this.semesterChartsData = const [],
      this.availableDates = const {}]);
}

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  GeneralStatusBloc() : super(GeneralStatusState()) {
    on<GeneralStatusStarted>(_getGeneralStatusData);
  }
}

_getGeneralStatusData(event, emit) async {
  final MainChartRepository mainRep = MainChartRepository();
  final SurveyInfoRepository infoRep = SurveyInfoRepository();
  final SemesterChartsRepository semesterRep = SemesterChartsRepository();

  final mainChartLinePoints = await mainRep.getLineAllData();
  final surveyInfo = await infoRep.getInfoCell();
  final semesterChartsData =
      await semesterRep.getLatestCourseProportionCharts();
  final availableDates = await semesterRep.findAvailableDates();
  emit(GeneralStatusState(
      mainChartLinePoints, surveyInfo, semesterChartsData, availableDates));
}
