const indexesService = require("../services/indexesService");

async function getIndex(req, res) {
  try {
    const indexes = await indexesService.getAllIndexes();
    res.send(indexes);
  } catch (e) {
    console.log("Indexes::Error getting index:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

async function getCourseIndex(req, res) {
  try {
    const courseId = req.params.courseId;
    const indexes = await indexesService.getCourseIndexes(courseId);
    res.send(indexes);
  } catch (e) {
    console.log("Indexes::Error getting course index:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  getIndex,
  getCourseIndex,
};
