import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/main_chart_repository.dart';
import 'package:ft_dashboard/data/repository/models/survey_info.dart';
import 'package:ft_dashboard/data/repository/survey_info_repository.dart';

class MainChartEvent {}

class MainChartStarted extends MainChartEvent {}

class MainChartState {
  List<List<double>> linePoints;
  SurveyInfo? surveyInfo;

  MainChartState(this.linePoints, this.surveyInfo);
}

class MainChartBloc extends Bloc<MainChartEvent, MainChartState> {
  final MainChartRepository mainRep = MainChartRepository();
  final SurveyInfoRepository infoRep = SurveyInfoRepository();

  MainChartBloc() : super(MainChartState([], null)) {
    on<MainChartStarted>(((event, emit) async {
      final chartLine = await mainRep.getLineAllData();
      final surveyInfo = await infoRep.getInfoCell();
      print(chartLine);
      emit(MainChartState(chartLine, surveyInfo));
    }));
  }
}
