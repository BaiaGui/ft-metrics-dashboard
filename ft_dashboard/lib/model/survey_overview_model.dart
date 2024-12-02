class SurveyOverviewModel {
  int? totalEnrolled;
  int? totalRespondents;
  String surveyParticipation = '';
  String averageIndex = '';

  SurveyOverviewModel.fromMap(Map<String, dynamic> map) {
    totalEnrolled = map["totalEnrolled"];
    totalRespondents = map["totalRespondents"];
    surveyParticipation = map["surveyParticipation"];
    averageIndex = map["averageIndex"];
  }
}
