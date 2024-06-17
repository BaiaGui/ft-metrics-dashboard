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

  GeneralStatusState(
      this.mainChartLinePoints, this.surveyInfo, this.semesterChartsData);
}

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  final MainChartRepository mainRep = MainChartRepository();
  final SurveyInfoRepository infoRep = SurveyInfoRepository();
  final SemesterChartsRepository semesterRep = SemesterChartsRepository();

  GeneralStatusBloc() : super(GeneralStatusState([], null, [])) {
    on<GeneralStatusStarted>(((event, emit) async {
      final mainChartLinePoints = await mainRep.getLineAllData();
      final surveyInfo = await infoRep.getInfoCell();
      final semesterChartsData =
          await semesterRep.getLatestCourseProportionCharts();
      print(mainChartLinePoints);
      emit(GeneralStatusState(
          mainChartLinePoints, surveyInfo, semesterChartsData));
    }));
  }
}
