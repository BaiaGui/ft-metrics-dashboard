class Subject {
  final String id;
  final String code;
  final String name;

  Subject({required this.id, required this.code, required this.name});
  factory Subject.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final code = json['codDisc'].toString();
    final name = json['nome'].toString();
    return Subject(id: id, code: code, name: name);
  }
}
