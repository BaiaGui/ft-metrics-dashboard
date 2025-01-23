const answerProportionService = require("../services/answerProportionService");

async function getCourseProportion(req, res) {
  try {
    const { year, semester } = req.query;
    if (!year || !semester) {
      throw { status: 400, message: "Year or Semester not defined" };
    }
    let courses = await answerProportionService.getCourseProportionsByTime(year, semester);
    res.send(courses);
  } catch (e) {
    console.log("AnswerProportionController::Error getting courses:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function getSubjectGroupProportion(req, res) {
  try {
    const { year, semester } = req.query;
    const courseId = req.params.courseId;
    if (!year || !semester) {
      throw { status: 400, message: "Year or Semester not defined" };
    }
    let groups = await answerProportionService.getGroupProportionsByCourse(year, semester, courseId);
    res.send(groups);
  } catch (e) {
    console.log("AnswerProportionController::Error getting subject groups:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function getSubjectsProportion(req, res) {
  try {
    const { year, semester } = req.query;
    const courseId = req.params.courseId;
    const groupId = req.params.groupId;
    if (!year || !semester) {
      throw { status: 400, message: "Year or Semester not defined" };
    }
    let subjects = await answerProportionService.getSubjectsProportionsByGroup(year, semester, courseId, groupId);
    res.send(subjects);
  } catch (e) {
    console.log("AnswerProportionController::Error getting subject groups:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

module.exports = {
  getCourseProportion,
  getSubjectGroupProportion,
  getSubjectsProportion,
};
