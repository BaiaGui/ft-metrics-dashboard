class FormQuestion {
  final String id;
  final String questionNum;
  final String answer;

  FormQuestion({
    required this.id,
    required this.questionNum,
    required this.answer,
  });

  factory FormQuestion.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final questionNum = json['numero_pergunta'].toString();
    final answer = json['resposta'].toString();

    return FormQuestion(id: id, questionNum: questionNum, answer: answer);
  }

  static List<FormQuestion> jsonArrayToList(List<dynamic> jsonArray) {
    final newList =
        jsonArray.map((question) => FormQuestion.fromJson(question));
    return newList.toList();
  }
}
