const surveyOverviewService = require("../services/surveyOverviewService");

async function getGeneralInfo(req, res) {
  const { year, semester } = req.body;
  try {
    let info = await surveyOverviewService.overviewByTime(year, semester);
    res.send(info);
  } catch (e) {
    console.log("SurveyOverview::Error getting survey info:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  getGeneralInfo,
};
