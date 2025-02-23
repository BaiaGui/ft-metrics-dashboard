const surveyOverviewService = require("../services/surveyOverviewService");

async function fetchSurveyInfo(req, res) {
  try {
    const { year, semester } = req.query;
    const { view, id } = req.params;
    const overview = await surveyOverviewService.fetchOverviewByTime(year, semester, view, id);
    res.send(overview);
  } catch (e) {
    console.log("SurveyOverview::Error while fetching survey overview:" + e.message);
    res.status(e.status || 500).json({ message: "Error while fetching survey overview" });
  }
}

module.exports = {
  fetchSurveyInfo,
};
