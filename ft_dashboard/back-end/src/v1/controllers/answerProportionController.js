const answerProportionService = require("../services/answerProportionService");

async function getCourseProportion(req, res) {
  try {
    const { year, semester } = req.query;
    console.log("year: " + year);
    console.log("semester:" + semester);
    if (!year || !semester) {
      throw { status: 400, message: "Year or Semester not defined" };
    }
    let courses = await answerProportionService.allAnswerProportions(year, semester);
    res.send(courses);
  } catch (e) {
    console.log("MainChartController::Error getting courses:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

module.exports = {
  getCourseProportion,
};
