import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/main_chart_repository.dart';
import 'package:ft_dashboard/data/repository/models/survey_info.dart';
import 'package:ft_dashboard/data/repository/survey_info_repository.dart';

class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusState {
  List<List<double>> linePoints;
  SurveyInfo? surveyInfo;

  GeneralStatusState(this.linePoints, this.surveyInfo);
}

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  final MainChartRepository mainRep = MainChartRepository();
  final SurveyInfoRepository infoRep = SurveyInfoRepository();

  GeneralStatusBloc() : super(GeneralStatusState([], null)) {
    on<GeneralStatusStarted>(((event, emit) async {
      final chartLine = await mainRep.getLineAllData();
      final surveyInfo = await infoRep.getInfoCell();
      print(chartLine);
      emit(GeneralStatusState(chartLine, surveyInfo));
    }));
  }
}
