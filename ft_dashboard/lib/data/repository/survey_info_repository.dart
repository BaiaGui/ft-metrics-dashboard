import 'package:ft_dashboard/data/provider/models/form.dart';
import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/subject_class.dart';
import 'package:ft_dashboard/data/provider/subject_class_provider.dart';
import 'package:ft_dashboard/data/repository/models/survey_info.dart';

class SurveyInfoRepository {
  final FormProvider formProvider = FormProvider();
  final SubjectClassProvider classProvider = SubjectClassProvider();

  var answerDist = [0, 0, 0, 0, 0, 0];

  double getIndexFromForms(List<Form> allForms) {
    for (var form in allForms) {
      answerDist[0] += form.numberOfAnswersByType(0);
      answerDist[1] += form.numberOfAnswersByType(1);
      answerDist[2] += form.numberOfAnswersByType(2);
      answerDist[3] += form.numberOfAnswersByType(3);
      answerDist[4] += form.numberOfAnswersByType(4);
      answerDist[5] += form.numberOfAnswersByType(5);
    }
    var questionTypeSum = 0;
    var numberOfAnswers = 0;
    for (var i = 0; i < 6; i++) {
      questionTypeSum += answerDist[i] * i;
      numberOfAnswers += answerDist[i];
    }

    final numberOfValidAnswers = numberOfAnswers - answerDist[0];
    final index = (questionTypeSum / numberOfValidAnswers - 1) / 4;
    return index;
  }

  int getTotalEnrollments(List<SubjectClass> allClasses) {
    var totalEnrollments = 0;
    for (var subjectClass in allClasses) {
      totalEnrollments += subjectClass.enrollments;
    }
    return totalEnrollments;
  }

  getInfoCell() async {
    final allForms = await formProvider.getFormData();
    final allClasses = await classProvider.getSubjectClassData();
    final respondents = allForms.length;
    final performanceIndex = getIndexFromForms(allForms);
    final totalEnrollments = getTotalEnrollments(allClasses);
    final surveyParticipation = respondents / totalEnrollments;

    // print(respondents);
    // print(performanceIndex);
    // print(totalEnrollments);
    // print(surveyParticipation);

    return SurveyInfo(
        respondents: respondents,
        totalEnrollments: totalEnrollments,
        surveyParticipation: surveyParticipation,
        performanceIndex: performanceIndex);
  }
}
