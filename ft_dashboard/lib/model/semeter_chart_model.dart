class SemesterChartModel {
  String dataSourceId = "";
  String chartName = "";
  List<double> proportions = [];

  SemesterChartModel.fromMap(map) {
    dataSourceId = map["dataId"];
    chartName = map["description"];
    proportions = [];
    if (map["proportion"].isNotEmpty) {
      List<dynamic> proportion = map["proportion"];

      proportions = [
        proportion[0]["count"],
        proportion[1]["count"],
        proportion[2]["count"],
        proportion[3]["count"],
        proportion[4]["count"],
        proportion[5]["count"]
      ];
    } else {
      proportions = [0, 0, 0, 0, 0, 0];
    }
  }

  static fromList(Map<String, dynamic> json) {
    List<dynamic> courseList = json["proportionGroup"];
    print("courseList: $courseList");
    return courseList
        .map((courseProportion) => SemesterChartModel.fromMap(courseProportion))
        .toList();
  }
}
