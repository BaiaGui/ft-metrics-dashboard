const answerProportionService = require("../services/answerProportionService");

async function fetchProportions(req, res) {
  try {
    const { year, semester } = req.query;
    const { view, id } = req.params;
    const proportions = await answerProportionService.fetchProportionsByPeriodAndView(year, semester, view, id);
    res.send(proportions);
  } catch (e) {
    console.log("AnswerProportion::" + e.message);
    res.status(e.status || 500).json({ message: "Error while fetching answer proportions" });
  }
}

module.exports = {
  fetchProportions,
};
