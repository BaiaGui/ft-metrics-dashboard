const surveyOverviewData = require("../data/surveyOverviewData");
const indexesService = require("./indexesService");

async function overviewByTime(selectedYear, selectedSemester) {
  try {
    let year, semester;
    if (selectedYear && selectedSemester) {
      year = selectedYear;
      semester = selectedSemester;
    } else {
      latestDate = await surveyOverviewData.findLatestDate();
      year = latestDate.year;
      semester = latestDate.semester;
    }
    const totalEnrolled = await surveyOverviewData.findTotalEnrolled(year, semester);
    const totalRespondents = await surveyOverviewData.findTotalRespondents(year, semester);
    const surveyParticipation = (totalRespondents / totalEnrolled).toFixed(3);
    const { indexInfra, indexStudent, indexTeacher } = await indexesService.getIndex(year, semester);
    const averageIndex = ((indexInfra + indexStudent + indexTeacher) / 3).toFixed(2);

    return {
      time: `${year}.${semester}`,
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

async function overviewByCourse(selectedYear, selectedSemester, courseId) {
  try {
    let year, semester;
    if (selectedYear && selectedSemester) {
      year = selectedYear;
      semester = selectedSemester;
    } else {
      latestDate = await surveyOverviewData.findLatestDate();
      year = latestDate.year;
      semester = latestDate.semester;
    }
    const totalEnrolled = await surveyOverviewData.findEnrolledInCourseByTime(year, semester, courseId);
    const totalRespondents = await surveyOverviewData.findRespondentsInCourseByTime(year, semester, courseId);
    const surveyParticipation = (totalRespondents / totalEnrolled).toFixed(3);
    const { indexInfra, indexStudent, indexTeacher } = await indexesService.getIndex(year, semester, courseId);
    const averageIndex = ((indexInfra + indexStudent + indexTeacher) / 3).toFixed(2);

    return {
      time: `${year}.${semester}`,
      totalEnrolled,
      totalRespondents,
      surveyParticipation,
      averageIndex,
    };
  } catch (e) {
    console.log("SurveyOverview::Error getting course survey info:" + e);
    throw e;
  }
}

async function overviewByGroup(selectedYear, selectedSemester, courseId, groupId) {
  try {
    let year, semester;
    if (selectedYear && selectedSemester) {
      year = selectedYear;
      semester = selectedSemester;
    } else {
      latestDate = await surveyOverviewData.findLatestDate();
      year = latestDate.year;
      semester = latestDate.semester;
    }
    const totalEnrolled = await surveyOverviewData.findEnrolledInGroupByTime(year, semester, courseId, groupId);
    const totalRespondents = await surveyOverviewData.findRespondentsInGroupByTime(year, semester, courseId, groupId);
    const surveyParticipation = (totalRespondents / totalEnrolled).toFixed(3);
    const { indexInfra, indexStudent, indexTeacher } = await indexesService.getIndex(year, semester, courseId, groupId);
    const averageIndex = ((indexInfra + indexStudent + indexTeacher) / 3).toFixed(2);

    return {
      time: `${year}.${semester}`,
      totalEnrolled,
      totalRespondents,
      surveyParticipation,
      averageIndex,
    };
  } catch (e) {
    console.log("SurveyOverview::Error getting group survey info:" + e);
    throw e;
  }
}

module.exports = {
  overviewByTime,
  overviewByCourse,
  overviewByGroup,
};
