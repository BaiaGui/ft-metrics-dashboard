class MainChartModel {
  List<List<dynamic>> infrastructureLine = [];
  List<List<dynamic>> teacherLine = [];
  List<List<dynamic>> studentLine = [];
  // double? infrastructureLine;
  // double? teacherLine;
  // double? studentLine;

  MainChartModel.fromMap(Map<String, dynamic> map) {
    infrastructureLine = map["indexInfra"];
    studentLine = map["indexStudent"];
    teacherLine = map["indexTeacher"];
  }
}
