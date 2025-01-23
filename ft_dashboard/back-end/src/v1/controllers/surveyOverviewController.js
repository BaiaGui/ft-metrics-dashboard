const surveyOverviewService = require("../services/surveyOverviewService");

async function getGeneralInfo(req, res) {
  const { year, semester } = req.query;
  try {
    let info = await surveyOverviewService.overviewByTime(year, semester);
    res.send(info);
  } catch (e) {
    console.log("SurveyOverview::Error getting survey info:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

async function getGeneralCourseInfo(req, res) {
  const { year, semester } = req.query;
  const courseId = req.params.courseId;
  try {
    let info = await surveyOverviewService.overviewByCourse(year, semester, courseId);
    res.send(info);
  } catch (e) {
    console.log("SurveyOverview::Error getting course survey info:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

async function getGeneralGroupInfo(req, res) {
  const { year, semester } = req.query;
  const courseId = req.params.courseId;
  const groupId = req.params.groupId;
  try {
    let info = await surveyOverviewService.overviewByGroup(year, semester, courseId, groupId);
    res.send(info);
  } catch (e) {
    console.log("SurveyOverview::Error getting group survey info:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  getGeneralInfo,
  getGeneralCourseInfo,
  getGeneralGroupInfo,
};
