import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/semester_charts_repository.dart';

class SemesterChartEvent {}

class SemesterChartChangedSemester extends SemesterChartEvent {
  String date;
  int year = 0;
  int semester = 0;

  SemesterChartChangedSemester(this.date) {
    List<String> dateValues = date.split(".");
    year = int.parse(dateValues[0]);
    semester = int.parse(dateValues[1]);
  }
}

class SemesterChartState {}

class SemesterChartBLoc extends Bloc<SemesterChartEvent, SemesterChartState> {
  SemesterChartBLoc() : super(SemesterChartState()) {
    on<SemesterChartChangedSemester>(_getChartsDataBySemester);
  }
}

_getChartsDataBySemester(
    SemesterChartChangedSemester event, Emitter emit) async {
  final SemesterChartsRepository semesterRep = SemesterChartsRepository();
  final List chartsData = await semesterRep.getCoursesProportionChartsByTime(
      year: event.year, semester: event.semester);
  emit(chartsData);
}
