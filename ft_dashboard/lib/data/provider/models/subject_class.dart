class SubjectClass {
  final String id;
  final String code;
  final String subjectCod;
  final String teacherCod;
  final String teacherCodTwo;
  final int enrollments;
  final int semester;
  final String startDate;
  final String finishDate;
  final int year;

  SubjectClass(
      {required this.id,
      required this.code,
      required this.subjectCod,
      required this.teacherCod,
      required this.teacherCodTwo,
      required this.enrollments,
      required this.semester,
      required this.startDate,
      required this.finishDate,
      required this.year});

  factory SubjectClass.fromJson(Map<String, dynamic> json) {
    final id = json['_id'].toString();
    final code = json['codTurma'].toString();
    final subjectCod = json['codDisc'].toString();
    final teacherCod = json['codProf'].toString();
    final teacherCodTwo = json['codProf_dois'].toString();
    final enrollments = json['matriculas'];
    final semester = json['semestre'];
    final startDate = json['inicio'].toString();
    final finishDate = json['fim'].toString();
    final year = json['ano'];

    return SubjectClass(
        id: id,
        code: code,
        subjectCod: subjectCod,
        teacherCod: teacherCod,
        teacherCodTwo: teacherCodTwo,
        enrollments: enrollments,
        semester: semester,
        startDate: startDate,
        finishDate: finishDate,
        year: year);
  }
}
