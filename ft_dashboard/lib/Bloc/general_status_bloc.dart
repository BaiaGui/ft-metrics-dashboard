import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/dashboard_repository.dart';
import 'package:ft_dashboard/model/main_chart_model.dart';
import 'package:ft_dashboard/model/semeter_chart_model.dart';
import 'package:ft_dashboard/model/survey_overview_model.dart';

class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusState {
  List<String>? availableDates = ["2022.1", "2022.2"];
  MainChartModel? mainChartData;
  SurveyOverviewModel? surveyData;
  List<SemesterChartModel>? semesterChartsData;

  GeneralStatusState(
      {this.mainChartData, this.surveyData, this.semesterChartsData});
}

class GeneralStatusBloc extends Bloc<GeneralStatusEvent, GeneralStatusState> {
  GeneralStatusBloc() : super(GeneralStatusState()) {
    on<GeneralStatusStarted>(_getGeneralStatusData);
  }
}

// _getGeneralStatusData(event, emit) async {
//   try {
//     final MainChartRepository mainRep = MainChartRepository();
//     final SurveyInfoRepository infoRep = SurveyInfoRepository();
//     final SemesterChartsRepository semesterRep = SemesterChartsRepository();

//     final mainChartLines = await mainRep.getAllLines();
//     final line1 = mainChartLines[0];
//     final line2 = mainChartLines[1];
//     final line3 = mainChartLines[2];

//     final surveyInfo = await infoRep.getInfoCell();
//     final semesterChartsData =
//         await semesterRep.getLatestCourseProportionCharts();
//     final availableDates = await semesterRep.findAvailableDates();
//     emit(GeneralStatusState(
//         line1, line2, line3, surveyInfo, semesterChartsData, availableDates));
//   } catch (e) {
//     print("GeneralStatusBloc: $e");
//   }
// }

_getGeneralStatusData(event, emit) async {
  try {
    final DashboardRepository dashRep = DashboardRepository();
    // final mainChartData = await dashRep.getIndex();
    // final surveyData = await dashRep.getSurveyOverview();
    // final semesterChartsData = await dashRep.getSemesterCharts();
    final allDashboardData = await Future.wait([
      dashRep.getIndex(),
      dashRep.getSurveyOverview(),
      dashRep.getSemesterCharts()
    ]);
    print("alldata: $allDashboardData");
    final mainChartData = allDashboardData[0] as MainChartModel;
    final surveyData = await allDashboardData[1] as SurveyOverviewModel;
    final semesterChartsData = allDashboardData[2] as List<SemesterChartModel>;
    print("semesterChartsData no bloc: $semesterChartsData ");
    emit(GeneralStatusState(
        mainChartData: mainChartData,
        surveyData: surveyData,
        semesterChartsData: semesterChartsData));
  } catch (e) {
    print('\n\n\n\nERRO NO BLOC: $e\n\n\n\n');
  }
}
