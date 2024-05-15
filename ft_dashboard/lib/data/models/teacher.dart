class Teacher {
  final String id;
  final String code;
  final String name;

  Teacher({
    required this.id,
    required this.code,
    required this.name,
  });
  factory Teacher.fromJson(Map<String, dynamic> json) {
    final id = json['_id'];
    final code = json['codProf'];
    final name = json['nome'];

    return Teacher(id: id, code: code, name: name);
  }
}
