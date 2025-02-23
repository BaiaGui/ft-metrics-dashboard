const surveyOverviewData = require("../data/surveyOverviewData");
const indexesService = require("./indexesService");

async function fetchOverviewByTime(yearParam, semesterParam, view, id) {
  const [year, semester] = await yearAndSemesterOrLatest(yearParam, semesterParam);
  const [totalEnrolled, totalRespondents] = await fetchByView(year, semester, view, id);
  const surveyParticipation = (totalRespondents / totalEnrolled).toFixed(3);
  const { indexInfra, indexStudent, indexTeacher } = await indexesService.fetchIndex(year, semester, view, id);
  const averageIndex = ((indexInfra + indexStudent + indexTeacher) / 3).toFixed(2);

  return {
    time: `${year}.${semester}`,
    totalEnrolled,
    totalRespondents,
    surveyParticipation,
    averageIndex,
  };
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

async function fetchByView(year, semester, view, id) {
  let totalEnrolled;
  let totalRespondents;
  switch (view) {
    case "general":
      totalEnrolled = await surveyOverviewData.countEnrolledInGeneralByPeriod(year, semester);
      totalRespondents = await surveyOverviewData.countGeneralResponsesByPeriod(year, semester);
      break;
    case "course":
      totalEnrolled = await surveyOverviewData.countEnrolledInCourseByPeriod(year, semester, id);
      totalRespondents = await surveyOverviewData.countResponsesForCourseByPeriod(year, semester, id);
      break;
    case "subjectGroup":
      totalEnrolled = await surveyOverviewData.countEnrolledInGroupByPeriod(year, semester, id);
      totalRespondents = await surveyOverviewData.countResponsesForGroupByPeriod(year, semester, id);
      break;
    case "subject":
      totalEnrolled = await surveyOverviewData.countEnrolledInSubjectByPeriod(year, semester, id);
      totalRespondents = await surveyOverviewData.countResponsesForSubjectByPeriod(year, semester, id);
      break;
    default:
      throw { status: 400, message: `surveyOverviewService::Invalid view value '${view}'` };
  }

  if (totalEnrolled == undefined || totalRespondents == undefined) {
    throw { status: 400, message: `surveyOverviewService::There is no data for id ${id} in view ${view}` };
  }

  return [totalEnrolled, totalRespondents];
}

module.exports = {
  fetchOverviewByTime,
};
