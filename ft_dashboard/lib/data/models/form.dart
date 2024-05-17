import 'package:ft_dashboard/data/models/form_question.dart';

class Form {
  final String id;
  final String classCod;
  final String startDate;
  final String finishDate;
  final List<FormQuestion> questions;

  Form({
    required this.id,
    required this.classCod,
    required this.startDate,
    required this.finishDate,
    required this.questions,
  });

  factory Form.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final classCod = json['codTurna'].toString();
    final startDate = json['dataIni'].toString();
    final finishDate = json['dataFim'].toString();
    final questions = FormQuestion.jsonArrayToList(json['questoes']);

    return Form(
        id: id,
        classCod: classCod,
        startDate: startDate,
        finishDate: finishDate,
        questions: questions);
  }

//  Função: calcular quantidades de resposta 0, 1, 2, 3, 4 e 5]
  int numberOfAnswersByType(int type) {
    var answersQuantity = 0;
    questions.forEach((question) {
      if (question.answer == '${type}') {
        answersQuantity++;
      }
    });
    return answersQuantity;
  }

  // List<int> numberOfAnswersByType(int type) {
  //   var answersQuantity = [0, 0, 0, 0, 0, 0];
  //   for (var question in questions) {
  //     switch (question) {
  //       case '0':
  //         answersQuantity[0]++;
  //         break;
  //       case '1':
  //         answersQuantity[1]++;
  //         break;
  //       case '2':
  //         answersQuantity[2]++;
  //         break;
  //       case '3':
  //         answersQuantity[3]++;
  //         break;
  //       case '4':
  //         answersQuantity[4]++;
  //         break;
  //       case '5':
  //         answersQuantity[5]++;
  //         break;
  //     }
  //   }
  //   return answersQuantity;
  // }

  // Retornar comentário pergunta 25
  //Retornar comentário da pergnta 26
}
