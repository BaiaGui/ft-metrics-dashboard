class MainChartModel {
  // List<List<double>> infrastructureLine = [];
  // List<List<double>> teacherLine = [];
  // List<List<double>> studentLine = [];
  double? infrastructureLine;
  double? teacherLine;
  double? studentLine;

  MainChartModel.fromMap(Map<String, dynamic> map) {
    infrastructureLine = map["indexInfra"];
    studentLine = map["indexStudent"];
    teacherLine = map["indexTeacher"];
  }
}
