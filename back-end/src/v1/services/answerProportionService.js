const answerProportionData = require("../data/answerProportionData");

async function fetchProportionsByPeriodAndView(yearParam, semesterParam, view, id) {
  const [year, semester] = await yearAndSemesterOrLatest(yearParam, semesterParam);
  let proportionGroup = [];
  switch (view) {
    case "general":
      let courses = await answerProportionData.getCourses();
      for (let course of courses) {
        let proportion = await answerProportionData.getCourseProportion(year, semester, course._id);
        proportionGroup.push({
          id: course._id,
          description: course.nomeCurso,
          proportion: proportion,
        });
      }
      return { proportionGroup };
      break;
    case "course":
      const groups = await answerProportionData.getGroupsbyCourse(id);
      for (let group of groups) {
        let proportion = await answerProportionData.getGroupProportion(group._id, year, semester);
        proportionGroup.push({
          id: group._id,
          description: group.descrição,
          proportion: proportion,
        });
      }
      return { proportionGroup };
      break;
    case "subjectGroup":
      const subjects = await answerProportionData.getSubjectsbyGroup(id);

      for (let subject of subjects) {
        let proportion = await answerProportionData.getSubjectProportion(year, semester, subject.codDisc);
        proportionGroup.push({
          id: subject.codDisc,
          description: subject.nome,
          proportion: proportion,
        });
      }
      return { proportionGroup };
      break;
    case "comments":
      const comments = await answerProportionData.fetchComments(year, semester, id);
      return comments;
      break;
    default:
      throw { status: 400, message: `answerProportionService::Invalid view value '${view}'` };
  }
}

async function yearAndSemesterOrLatest(selectedYear, selectedSemester) {
  let year, semester;
  if (selectedYear && selectedSemester) {
    year = selectedYear;
    semester = selectedSemester;
  } else {
    latestDate = await surveyOverviewData.findLatestDate();
    year = latestDate.year;
    semester = latestDate.semester;
  }
  return [year, semester];
}

module.exports = {
  fetchProportionsByPeriodAndView,
};
