import 'package:ft_dashboard/data/provider/models/form.dart';

double getIndexFromForms(List<Form> allForms) {
  if (allForms.isEmpty) {
    return -1;
  }

  var answerDist = [0, 0, 0, 0, 0, 0];
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

yearToXcoord(int year) {
  int year0 = 2020;
  int yearXvalue = 2 * (year - year0);
  return yearXvalue;
}
