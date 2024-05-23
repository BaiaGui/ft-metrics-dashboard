import 'package:ft_dashboard/data/provider/form_provider.dart';
import 'package:ft_dashboard/data/provider/models/cohort.dart';
import 'package:ft_dashboard/data/provider/cohort_provider.dart';
import 'package:ft_dashboard/data/repository/models/survey_info.dart';
import 'package:ft_dashboard/data/utils.dart';

class SurveyInfoRepository {
  final FormProvider formProvider = FormProvider();
  final CohortProvider cohortProvider = CohortProvider();

  getInfoCell() async {
    final allForms = await formProvider.getFormData();
    final allCohorts = await cohortProvider.getCohortData();
    final respondents = allForms.length;
    final performanceIndex = getIndexFromForms(allForms);
    final totalEnrollments = getTotalEnrollments(allCohorts);
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

  int getTotalEnrollments(List<Cohort> allCohorts) {
    var totalEnrollments = 0;
    for (var cohort in allCohorts) {
      totalEnrollments += cohort.enrollments;
    }
    return totalEnrollments;
  }
}
