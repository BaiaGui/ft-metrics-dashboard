import 'package:ft_dashboard/data/provider/models/form_question.dart';

class Form {
  final String id;
  final String cohortCod;
  final String startDate;
  final String finishDate;
  final List<FormQuestion> questions;

  Form({
    required this.id,
    required this.cohortCod,
    required this.startDate,
    required this.finishDate,
    required this.questions,
  });

  factory Form.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final cohortCod = json['codTurma'].toString();
    final startDate = json['dataIni'].toString();
    final finishDate = json['dataFim'].toString();
    final questions = FormQuestion.jsonArrayToList(json['questoes']);

    return Form(
        id: id,
        cohortCod: cohortCod,
        startDate: startDate,
        finishDate: finishDate,
        questions: questions);
  }

  int numberOfAnswersByType({required questionCategory, required answerType}) {
    var filteredQuestions = questions
        .where((question) => question.category == questionCategory)
        .toList();
    var answersQuantity = 0;
    for (var question in filteredQuestions) {
      if (question.answer == '$answerType') {
        answersQuantity++;
      }
    }
    return answersQuantity;
  }

//  Função: calcular quantidade de respostas de um tipo (0, 1, 2, ...) OLD VERSION
  int answerTypeQuantity(
    int type,
  ) {
    var answersQuantity = 0;
    for (var question in questions) {
      if (question.answer == '$type') {
        answersQuantity++;
      }
    }
    return answersQuantity;
  }

  // Retornar comentário pergunta 25
  //Retornar comentário da pergnta 26
}
