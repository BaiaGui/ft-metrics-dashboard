transformXcoordToYear(int coord) {
  int year0 = 2020;
  double xYear = (coord / 2) + year0;
  if (xYear == xYear.floor()) {
    return "$xYear.1";
  } else {
    int baseYear = xYear.floor();
    return "$baseYear.2";
  }
}

transformYearStringToIntXcoord(String year) {
  var splitedYearSemester = year.split('.');
  int numYear = int.parse(splitedYearSemester[0]);
  String semester = splitedYearSemester[1];
  int year0 = 2020;
  int yearXvalue = 2 * (numYear - year0);

  if (semester == '1') {
    return yearXvalue;
  } else {
    return yearXvalue + 1;
  }
}
