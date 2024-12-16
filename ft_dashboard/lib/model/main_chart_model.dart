class MainChartModel {
  List<dynamic> infrastructureLine = [];
  List<dynamic> teacherLine = [];
  List<dynamic> studentLine = [];
  // double? infrastructureLine;
  // double? teacherLine;
  // double? studentLine;

  MainChartModel.fromMap(Map<String, dynamic> map) {
    infrastructureLine = map["indexInfra"];
    studentLine = map["indexStudent"];
    teacherLine = map["indexTeacher"];
  }
}
