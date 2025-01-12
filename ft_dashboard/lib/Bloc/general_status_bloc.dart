import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/events/general_status_event.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';
import 'package:ft_dashboard/repository/dashboard_repository.dart';

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  GeneralStatusBloc() : super(GeneralStatusState()) {
    on<GeneralStatusStarted>(_getInitialStatusData);
    on<GeneralStatusChangedTime>(_getDataFromPeriod);
    on<CourseSelectedEvent>(_getCourseData);
  }

  _getInitialStatusData(event, emit) async {
    //TODO: Remove hardcoded values
    try {
      final dashboardData = await _getDashboardData(2022, 2);
      emit(dashboardData);
    } catch (e) {
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  _getDataFromPeriod(event, emit) async {
    emit(GeneralStatusState());
    var [year, semester] = event.year.split(".");
    try {
      final dashboardData = await _getDashboardData(year, semester);
      emit(dashboardData);
    } catch (e) {
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  _getCourseData(event, emit) async {
    try {
      emit(GeneralStatusState());

      var [year, semester] = event.dataTime.split(".");
      var courseId = event.dataSourceId;

      if (event.dataSourceId == null || event.dataTime == null) {
        throw Exception('Invalid course data provided');
      }
      final DashboardRepository dashRep = DashboardRepository();

      final allDashboardData = await Future.wait([
        dashRep.getCourseIndex(courseId),
        dashRep.getCourseSurveyOverview(year, semester, courseId),
        dashRep.getCourseGroupsCharts(year, semester, courseId),
        dashRep.getAvailableYears(),
      ]);

      final mainChartData = allDashboardData[0] as MainChartModel;
      final surveyData = allDashboardData[1] as SurveyOverviewModel;
      final semesterChartsData =
          allDashboardData[2] as List<SemesterChartModel>;
      final availableYears = allDashboardData[3] as List<String>;

      emit(GeneralStatusState(
          mainChartData: mainChartData,
          surveyData: surveyData,
          semesterChartsData: semesterChartsData,
          availableDates: availableYears,
          selectedDate: event.dataSourceId));
    } catch (e) {
      print('Error in _getCourseData: $e');
      print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
    }
  }

  _getDashboardData(year, semester) async {
    final DashboardRepository dashRep = DashboardRepository();
    final allDashboardData = await Future.wait([
      dashRep.getIndex(),
      dashRep.getSurveyOverview(year, semester),
      dashRep.getSemesterCharts(year, semester),
      dashRep.getAvailableYears(),
    ]);

    final mainChartData = allDashboardData[0] as MainChartModel;
    final surveyData = allDashboardData[1] as SurveyOverviewModel;
    final semesterChartsData = allDashboardData[2] as List<SemesterChartModel>;
    final availableYears = allDashboardData[3] as List<String>;

    return GeneralStatusState(
      mainChartData: mainChartData,
      surveyData: surveyData,
      semesterChartsData: semesterChartsData,
      availableDates: availableYears,
      selectedDate: "$year.$semester",
    );
  }
}
