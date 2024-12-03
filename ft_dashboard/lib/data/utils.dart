import 'package:ft_dashboard/data/provider/models/form.dart';

double getIndexByQuestionCategory(List<Form> allForms, category) {
  if (allForms.isEmpty) {
    return -1;
  }

  var answerDist = [0, 0, 0, 0, 0, 0];
  for (var form in allForms) {
    answerDist[0] +=
        form.numberOfAnswersByType(answerType: 0, questionCategory: category);
    answerDist[1] +=
        form.numberOfAnswersByType(answerType: 1, questionCategory: category);
    answerDist[2] +=
        form.numberOfAnswersByType(answerType: 2, questionCategory: category);
    answerDist[3] +=
        form.numberOfAnswersByType(answerType: 3, questionCategory: category);
    answerDist[4] +=
        form.numberOfAnswersByType(answerType: 4, questionCategory: category);
    answerDist[5] +=
        form.numberOfAnswersByType(answerType: 5, questionCategory: category);
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

//Temporary old version
double getIndexFromForms(List<Form> allForms) {
  if (allForms.isEmpty) {
    return -1;
  }

  var answerDist = [0, 0, 0, 0, 0, 0];
  for (var form in allForms) {
    answerDist[0] += form.answerTypeQuantity(0);
    answerDist[1] += form.answerTypeQuantity(1);
    answerDist[2] += form.answerTypeQuantity(2);
    answerDist[3] += form.answerTypeQuantity(3);
    answerDist[4] += form.answerTypeQuantity(4);
    answerDist[5] += form.answerTypeQuantity(5);
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

transformYearToXcoord(int year) {
  int year0 = 2020;
  int yearXvalue = 2 * (year - year0);
  return yearXvalue;
}

transformXcoordToYear(int coord) {
  int year0 = 2020;
  double xYear = (coord / 2) + year0;
  if (xYear == xYear.floor()) {
    return "$xYear.1";
  } else {
    int baseYear = xYear.floor();
    return "$baseYear.2";
  }
}

transformYearStringToIntXcoord(String year) {
  var splitedYearSemester = year.split('.');
  int numYear = int.parse(splitedYearSemester[0]);
  String semester = splitedYearSemester[1];
  int year0 = 2020;
  int yearXvalue = 2 * (numYear - year0);

  if (semester == '1') {
    return yearXvalue;
  } else {
    return yearXvalue + 1;
  }
}

// Set<int> findUniqueYears(List<Cohort> cohorts) {
//   Set<int> uniqueYears = {};
//   for (var cohort in cohorts) {
//     uniqueYears.add(cohort.year);
//   }
//   return (uniqueYears);
// }
