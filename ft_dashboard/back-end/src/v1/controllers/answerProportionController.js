const answerProportionService = require("../services/answerProportionService");

async function getCourseProportion(req, res) {
  try {
    let courses = await answerProportionService.allAnswerProportions();
    res.send(courses);
  } catch (e) {
    console.log("MainChartController::Error getting courses:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

module.exports = {
  getCourseProportion,
};
