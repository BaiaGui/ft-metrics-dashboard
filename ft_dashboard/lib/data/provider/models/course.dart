class Course {
  final String id;
  final String name;
  final String subjects;

  Course({required this.id, required this.name, required this.subjects});

  factory Course.fromJson(Map<dynamic, String> json) {
    final id = json['_id'].toString();
    final name = json['nomeCurso'].toString();
    final subjects = json['cod_disciplinas'].toString();
    return Course(id: id, name: name, subjects: subjects);
  }
}
