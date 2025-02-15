import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/events/general_status_event.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/repository/dashboard_repository.dart';

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  GeneralStatusBloc()
      : super(GeneralStatusState(currentView: ViewType.loading)) {
    on<GeneralStatusStarted>(_getInitialStatusData);
    on<GeneralStatusChangedTime>(_getDataFromPeriod);
    on<ChartClicked>(_handleChartClick);
    // on<CourseSelectedEvent>(_getCourseData);
    // on<GroupSelectedEvent>(_getGroupData);
  }

  _getInitialStatusData(event, emit) async {
    //TODO: Remove hardcoded values
    try {
      final curView = state.currentView;
      final dashboardData = await _getDashboardData(curView, "2022", "2");
      emit(dashboardData);
    } catch (e) {
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  _getDataFromPeriod(event, emit) async {
    try {
      final curState = state;
      final curView = state.currentView;
      var [year, semester] = event.year.split(".");
      print("current state: ${curState.selectedCourseId}");

      emit(GeneralStatusState(currentView: ViewType.loading));
      final dashboardData = await _getDashboardData(
          curView,
          year,
          semester,
          curState.selectedCourseId,
          curState.selectedGroupId,
          curState.selectedSubjectId);
      print("state enviado: ${dashboardData.selectedCourseId}");
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
          await _getDashboardData(nextView, year, semester, nextviewId);

      emit(dashboardData);
    } catch (e) {
      print('Error in _handleChartClick: $e');
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  // _getCourseData(event, emit) async {
  //   try {
  //     emit(GeneralStatusState(currentView: ViewType.loading));

  //     var [year, semester] = event.dataTime.split(".");
  //     var courseId = event.dataSourceId;

  //     if (event.dataSourceId == null || event.dataTime == null) {
  //       throw Exception('Invalid course data provided');
  //     }

  //     final dashboardData = await _getDashboardData(year, semester, courseId);

  //     emit(dashboardData);
  //   } catch (e) {
  //     print('Error in _getCourseData: $e');
  //     print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
  //   }
  // }

  // _getGroupData(event, emit) async {
  //   try {
  //     emit(GeneralStatusState());
//
  //     var [year, semester] = event.dataTime.split(".");
  //     var groupId = event.dataSourceId;
//
  //     if (event.dataSourceId == null || event.dataTime == null) {
  //       throw Exception('Invalid course data provided');
  //     }
//
  //     final dashboardData =
  //         await _getDashboardData(year, semester, groupId, groupId);
//
  //     emit(dashboardData);
  //   } catch (e) {
  //     print('Error in _getCourseData: $e');
  //     print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
  //   }
  // }

  Future<GeneralStatusState> _getDashboardData(
    ViewType curView,
    String year,
    String semester, [
    String? courseId,
    String? groupId,
    String? subjectId,
  ]) async {
    final DashboardRepository dashRep = DashboardRepository();
    print(
        "getting data from $year.$semester with courseId: $courseId, groupId: $groupId, subjectId: $subjectId");
    final allDashboardData = await dashRep.getDashboardData(
        year, semester, courseId, groupId, subjectId);

    final mainChartData = allDashboardData[0] as MainChartModel;
    final surveyData = allDashboardData[1] as SurveyOverviewModel;
    final semesterChartsData = allDashboardData[2] as List<SemesterChartModel>;
    final availableYears = allDashboardData[3] as List<String>;
    final date = "$year.$semester";
    print(
        " mainChartData: $mainChartData,\n surveyData: $surveyData,\n semesterChartsData: $semesterChartsData,\n availableDates: $availableYears,\n selectedDate: $date,\n selectedCourseId: $courseId,\n selectedGroupId: $groupId,\n selectedSubjectId: $subjectId,");
    return GeneralStatusState(
        mainChartData: mainChartData,
        surveyData: surveyData,
        semesterChartsData: semesterChartsData,
        availableDates: availableYears,
        selectedDate: date,
        selectedCourseId: courseId,
        selectedGroupId: groupId,
        selectedSubjectId: subjectId,
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
