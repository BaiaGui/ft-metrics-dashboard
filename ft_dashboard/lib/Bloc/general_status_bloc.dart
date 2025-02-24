import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/events/general_status_event.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/model/view_type.dart';
import 'package:ft_dashboard/repository/dashboard_repository.dart';

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  GeneralStatusBloc()
      : super(GeneralStatusState(currentView: ViewType.loading)) {
    on<GeneralStatusStarted>(_getInitialStatusData);
    on<GeneralStatusChangedTime>(_getDataFromPeriod);
    on<ChartClicked>(_handleChartClick);
  }

  _getInitialStatusData(event, emit) async {
    //TODO: Remove hardcoded values
    try {
      final curView = ViewType.general;
      final dashboardData = await _getDashboardData(curView, "0", "2022", "2");
      emit(dashboardData);
    } catch (e) {
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  _getDataFromPeriod(event, emit) async {
    try {
      emit(GeneralStatusState(currentView: ViewType.loading));
      var [year, semester] = event.year.split(".");
      final dashboardData = await _getDashboardData(
          state.currentView, state.dataId, year, semester);
      emit(dashboardData);
    } catch (e) {
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  _handleChartClick(event, emit) async {
    try {
      final nextView = _findNextView(state.currentView);
      emit(GeneralStatusState(currentView: ViewType.loading));

      var [year, semester] = event.dataTime.split(".");
      var nextviewId = event.dataSourceId;

      if (event.dataSourceId == null || event.dataTime == null) {
        throw Exception('Invalid data provided');
      }

      final dashboardData =
          await _getDashboardData(nextView, nextviewId, year, semester);

      emit(dashboardData);
    } catch (e) {
      print('Error in _handleChartClick: $e');
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  Future<GeneralStatusState> _getDashboardData(
    ViewType curView,
    String? id,
    String year,
    String semester,
  ) async {
    final DashboardRepository dashRep = DashboardRepository();

    final allDashboardData =
        await dashRep.getDashboardData(curView, id, year, semester);

    final mainChartData = allDashboardData[0] as MainChartModel;
    final surveyData = allDashboardData[1] as SurveyOverviewModel;
    final semesterChartsData = allDashboardData[2] as List<SemesterChartModel>;
    final availableYears = allDashboardData[3] as List<String>;
    final date = "$year.$semester";

    return GeneralStatusState(
        mainChartData: mainChartData,
        surveyData: surveyData,
        semesterChartsData: semesterChartsData,
        availableDates: availableYears,
        selectedDate: date,
        dataId: id,
        currentView: curView);
  }

  ViewType _findNextView(ViewType currentView) {
    switch (currentView) {
      case ViewType.general:
        return ViewType.course;
      case ViewType.course:
        return ViewType.subjectGroup;
      case ViewType.subjectGroup:
        return ViewType.subject;
      case ViewType.subject:
        return ViewType.subject;
      case ViewType.error:
        return ViewType.error;
      case ViewType.loading:
        return ViewType.loading;
    }
  }
}
