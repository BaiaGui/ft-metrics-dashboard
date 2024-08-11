class FormQuestion {
  final String id;
  final String questionNum;
  final String answer;
  final int category;

  FormQuestion(
      {required this.id,
      required this.questionNum,
      required this.answer,
      required this.category});

  factory FormQuestion.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final questionNum = json['numero_pergunta'].toString();
    final answer = json['resposta'].toString();
    final category = _findQuestionCategory(questionNum);

    return FormQuestion(
        id: id, questionNum: questionNum, answer: answer, category: category);
  }

  static List<FormQuestion> jsonArrayToList(List<dynamic> jsonArray) {
    final newList =
        jsonArray.map((question) => FormQuestion.fromJson(question));
    return newList.toList();
  }
}

_findQuestionCategory(questionNumber) {
  try {
    final question = int.parse(questionNumber);
    if (question >= 1 && question <= 5) {
      return 1;
    }
    if (question >= 6 && question <= 12) {
      return 2;
    }
    if (question >= 13 && question <= 24) {
      return 3;
    }
    if (question >= 25 && question <= 26) {
      return 4;
    } else {
      throw "Question number is not in a category";
    }
  } catch (e) {
    print(
        "FormQuestionModel:: An error ocorruded when finding a question category: $e");
  }
}
