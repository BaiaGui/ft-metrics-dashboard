class Course {
  final String id;
  final String name;
  final List<String> subjects;

  Course({required this.id, required this.name, required this.subjects});

  factory Course.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final name = json['nomeCurso'].toString();
    final subjects = (json['cod_disciplinas'] as List)
        .map((item) => item as String)
        .toList();
    return Course(id: id, name: name, subjects: subjects);
  }
}
