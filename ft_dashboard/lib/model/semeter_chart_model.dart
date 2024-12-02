class SemesterChartModel {
  String course = "";
  int? propType0;
  int? propType1;
  int? propType2;
  int? propType3;
  int? propType4;
  int? propType5;

  SemesterChartModel.fromMap(map) {
    List<dynamic> proportion = map["proportion"];

    course = map["course"];
    propType0 = proportion[0]["count"];
    propType1 = proportion[1]["count"];
    propType2 = proportion[2]["count"];
    propType3 = proportion[3]["count"];
    propType4 = proportion[4]["count"];
    propType5 = proportion[5]["count"];
  }

  static fromList(Map<String, dynamic> json) {
    List<dynamic> courseList = json["proportionGroup"];
    return courseList
        .map((courseProportion) => SemesterChartModel.fromMap(courseProportion))
        .toList();
  }
}
