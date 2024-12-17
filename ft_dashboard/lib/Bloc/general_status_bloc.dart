import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/repository/dashboard_repository.dart';

class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusChangedTime extends GeneralStatusEvent {}

class GeneralStatusState {
  List<String>? availableDates = [];
  MainChartModel? mainChartData;
  SurveyOverviewModel? surveyData;
  List<SemesterChartModel>? semesterChartsData;

  GeneralStatusState(
      {this.mainChartData,
      this.surveyData,
      this.semesterChartsData,
      this.availableDates});
}

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  GeneralStatusBloc() : super(GeneralStatusState()) {
    on<GeneralStatusStarted>(_getGeneralStatusData);
  }
}

_getGeneralStatusData(event, emit) async {
  try {
    final DashboardRepository dashRep = DashboardRepository();

    final allDashboardData = await Future.wait([
      dashRep.getIndex(),
      dashRep.getSurveyOverview(),
      dashRep.getSemesterCharts(),
      dashRep.getAvailableYears(),
    ]);

    final mainChartData = allDashboardData[0] as MainChartModel;
    final surveyData = allDashboardData[1] as SurveyOverviewModel;
    final semesterChartsData = allDashboardData[2] as List<SemesterChartModel>;
    final availableYears = allDashboardData[3] as List<String>;

    emit(GeneralStatusState(
        mainChartData: mainChartData,
        surveyData: surveyData,
        semesterChartsData: semesterChartsData,
        availableDates: availableYears));
  } catch (e) {
    print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
  }
}
