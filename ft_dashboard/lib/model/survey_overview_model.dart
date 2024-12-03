class SurveyOverviewModel {
  int? totalEnrolled;
  int? totalRespondents;
  String? surveyParticipation;
  String? averageIndex;

  SurveyOverviewModel.fromMap(Map<String, dynamic> map) {
    totalEnrolled = map["totalEnrolled"];
    totalRespondents = map["totalRespondents"];
    surveyParticipation =
        (double.parse(map["surveyParticipation"]) * 100).toStringAsFixed(2);
    averageIndex = map["averageIndex"];
  }
}
