import 'package:flutter/cupertino.dart';
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
      : super(GeneralStatusState(
            currentView: ViewType.loading, path: [PathSegment()])) {
    on<GeneralStatusStarted>(_getInitialStatusData);
    on<GeneralStatusChangedTime>(_getDataFromPeriod);
    on<ChartClicked>(_handleChartClick);
    on<BreadCrumbClicked>(_handleBreadCrumbNavigation);
  }

  _getInitialStatusData(event, emit) async {
    //TODO: Remove hardcoded values
    try {
      final curView = ViewType.general;
      final curpath = state.path;
      final dashboardData =
          await _getDashboardData(curView, "0", "2022", "2", curpath);
      emit(dashboardData);
    } catch (e) {
      print(e);
    }
  }

  _getDataFromPeriod(event, emit) async {
    try {
      final curState = state;
      emit(GeneralStatusState(currentView: ViewType.loading, path: state.path));
      var [year, semester] = event.year.split(".");
      final dashboardData = await _getDashboardData(
          curState.currentView, curState.dataId, year, semester, state.path);
      emit(dashboardData);
    } catch (e) {
      print(e);
    }
  }

  _handleChartClick(event, emit) async {
    try {
      final nextView = _findNextView(state.currentView);

      final currentPathSegment = PathSegment(
          id: event.dataSourceId, name: event.dataSourceName, view: nextView);
      state.path.add(currentPathSegment);

      emit(GeneralStatusState(currentView: ViewType.loading, path: state.path));

      var [year, semester] = event.dataTime.split(".");
      var nextviewId = event.dataSourceId;

      if (event.dataSourceId == null || event.dataTime == null) {
        throw Exception('Invalid data provided');
      }

      final dashboardData = await _getDashboardData(
          nextView, nextviewId, year, semester, state.path);

      emit(dashboardData);
    } catch (e) {
      print(e);
    }
  }

  _handleBreadCrumbNavigation(event, emit) async {
    try {
      var newPath;

      int index = state.path.indexWhere(
          (pathSegment) => pathSegment.name == event.dataSourceName);

      if (index != -1) {
        newPath = state.path.sublist(0, index + 1);
      }

      var [year, semester] = event.dataTime.split(".");

      var nextviewId = event.dataSourceId;
      emit(GeneralStatusState(currentView: ViewType.loading, path: newPath));
      if (event.dataSourceId == null || event.dataTime == null) {
        throw Exception('Invalid data provided');
      }

      final dashboardData = await _getDashboardData(
          event.pathView, nextviewId, year, semester, state.path);

      emit(dashboardData);
    } catch (e) {
      print(e);
    }
  }

  Future<GeneralStatusState> _getDashboardData(
    ViewType curView,
    String? id,
    String year,
    String semester,
    List<PathSegment> path,
  ) async {
    final DashboardRepository dashRep = DashboardRepository();

    final allDashboardData =
        await dashRep.getDashboardData(curView, id, year, semester);

    final mainChartData = allDashboardData[0] as MainChartModel;
    final surveyData = allDashboardData[1] as SurveyOverviewModel;
    final semesterChartsData = allDashboardData[2] as List<SemesterChartModel>;
    final availableYears = allDashboardData[3] as List<String>;
    final date = "$year.$semester";

    List<String>? comments25, comments26;
    if (curView == ViewType.subject) {
      [comments25, comments26] =
          await dashRep.fetchCommentsBySubject(year, semester, id);
    }

    return GeneralStatusState(
      mainChartData: mainChartData,
      surveyData: surveyData,
      semesterChartsData: semesterChartsData,
      availableDates: availableYears,
      selectedDate: date,
      dataId: id,
      comments25: comments25,
      comments26: comments26,
      currentView: curView,
      path: state.path,
    );
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
