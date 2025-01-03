const surveyOverviewData = require("../data/surveyOverviewData");
const indexesService = require("./indexesService");

async function overviewByTime(selectedYear, selectedSemester) {
  let year, semester;
  try {
    if (selectedYear && selectedSemester) {
      year = selectedYear;
      semester = selectedSemester;
    } else {
      latestDate = await surveyOverviewData.findLatestDate();
      year = latestDate.year;
      semester = latestDate.semester;
    }
    const totalEnrolled = await surveyOverviewData.findTotalEnrolled(lYear, lSemester);
    const totalRespondents = await surveyOverviewData.findTotalRespondents(lYear, lSemester);
    const surveyParticipation = (totalRespondents / totalEnrolled).toFixed(3);
    const { indexInfra, indexStudent, indexTeacher } = await indexesService.getIndex(lYear, lSemester);
    const averageIndex = ((indexInfra + indexStudent + indexTeacher) / 3).toFixed(2);

    return {
      time: `${lYear}.${lSemester}`,
      totalEnrolled,
      totalRespondents,
      surveyParticipation,
      averageIndex,
    };
  } catch (e) {
    console.log("SurveyOverview::Error getting survey info:" + e);
    throw e;
  }
}

module.exports = {
  overviewByTime,
};
