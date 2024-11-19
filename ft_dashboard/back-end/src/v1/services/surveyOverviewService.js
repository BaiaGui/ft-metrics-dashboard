const surveyOverviewData = require("../data/surveyOverviewData");
const indexesService = require("./indexesService");

async function overviewByTime(year, semester) {
  let lYear = year;
  let lSemester = semester;
  try {
    if (!year || !semester) {
      latestDate = await surveyOverviewData.findLatestDate();
      lYear = latestDate.year;
      lSemester = latestDate.semester;
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
