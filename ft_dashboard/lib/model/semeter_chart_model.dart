class SemesterChartModel {
  String chartName = "";
  List<double> proportions = [];

  SemesterChartModel.fromMap(map) {
    List<dynamic> proportion = map["proportion"];

    chartName = map["course"];
    proportions = [
      proportion[0]["count"],
      proportion[1]["count"],
      proportion[2]["count"],
      proportion[3]["count"],
      proportion[4]["count"],
      proportion[5]["count"]
    ];
  }

  static fromList(Map<String, dynamic> json) {
    List<dynamic> courseList = json["proportionGroup"];
    return courseList
        .map((courseProportion) => SemesterChartModel.fromMap(courseProportion))
        .toList();
  }
}
