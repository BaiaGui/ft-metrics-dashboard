import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/main_chart_repository.dart';
import 'package:ft_dashboard/data/repository/models/survey_info.dart';
import 'package:ft_dashboard/data/repository/semester_charts_repository.dart';
import 'package:ft_dashboard/data/repository/survey_info_repository.dart';

class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusState {
  List<List<double>> line1;
  List<List<double>> line2;
  List<List<double>> line3;
  SurveyInfo? surveyInfo;
  List semesterChartsData;
  Set<String> availableDates;

  GeneralStatusState(
      [this.line1 = const [],
      this.line2 = const [],
      this.line3 = const [],
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
  try {
    final MainChartRepository mainRep = MainChartRepository();
    final SurveyInfoRepository infoRep = SurveyInfoRepository();
    final SemesterChartsRepository semesterRep = SemesterChartsRepository();

    final mainChartLines = await mainRep.getAllLines();
    final line1 = mainChartLines[0];
    final line2 = mainChartLines[1];
    final line3 = mainChartLines[2];

    final surveyInfo = await infoRep.getInfoCell();
    final semesterChartsData =
        await semesterRep.getLatestCourseProportionCharts();
    final availableDates = await semesterRep.findAvailableDates();
    emit(GeneralStatusState(
        line1, line2, line3, surveyInfo, semesterChartsData, availableDates));
  } catch (e) {
    print("GeneralStatusBloc: $e");
  }
}
