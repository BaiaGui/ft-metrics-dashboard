const answerProportionService = require("../services/answerProportionService");

async function getAllCourses(req, res) {
  try {
    let courses = answerProportionService.getAllCourses();
    res.send(courses);
  } catch (e) {
    console.log("MainChartController::Error getting courses:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

module.exports = {
  getAllCourses,
};
