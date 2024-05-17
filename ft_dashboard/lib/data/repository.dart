import 'package:ft_dashboard/data/provider/form_provider.dart';

class Repository {
  final FormProvider formProvider = FormProvider();

  var answerDist = [0, 0, 0, 0, 0, 0];

  getIndexFromAllForms() async {
    var allForms = await formProvider.getFormData();

    for (var form in allForms) {
      answerDist[0] += form.numberOfAnswersByType(0);
      answerDist[1] += form.numberOfAnswersByType(1);
      answerDist[2] += form.numberOfAnswersByType(2);
      answerDist[3] += form.numberOfAnswersByType(3);
      answerDist[4] += form.numberOfAnswersByType(4);
      answerDist[5] += form.numberOfAnswersByType(5);
    }
    print("quantidade de respostas: $answerDist");
    var s = 0;
    var sum = 0;
    for (var i = 0; i < 6; i++) {
      s += answerDist[i] * i;
      sum += answerDist[i];
    }
    print(s);
    print(sum);
    sum = sum - answerDist[0];
    print("indice: ${(s / sum - 1) / 4}");
  }
}
