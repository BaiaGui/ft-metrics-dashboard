const indexesService = require("../services/indexesService");

// async function getIndex(req, res) {
//   try {
//     const indexes = await indexesService.getAllIndexes();
//     res.send(indexes);
//   } catch (e) {
//     console.log("Indexes::Error getting general index history:" + e.message);
//     res.status(e.status || 500).json({ message: e.message || e });
//   }
// }

// async function getCourseIndex(req, res) {
//   try {
//     const courseId = req.params.courseId;
//     const indexes = await indexesService.getCourseIndexes(course, courseId);
//     res.send(indexes);
//   } catch (e) {
//     console.log("Indexes::Error getting course index history:" + e.message);
//     res.status(e.status || 500).json({ message: e.message || e });
//   }
// }

// async function getSubjectGroupIndex(req, res) {
//   try {
//     const groupId = req.params.groupId;
//     const indexes = await indexesService.getSubjectGroupIndexes(subjectGroup, groupId);
//     res.send(indexes);
//   } catch (e) {
//     console.log("Indexes::Error getting subject group index history:" + e.message);
//     res.status(e.status || 500).json({ message: e.message || e });
//   }
// }

async function fetchIndexHistory(req, res) {
  try {
    const { view, id } = req.params;
    const indexes = await indexesService.fetchHistoryByViewAndId(view, id);
    res.send(indexes);
  } catch (e) {
    console.log(`Indexes::Error while fetching index history:` + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  // getIndex,
  // getCourseIndex,
  // getSubjectGroupIndex,
  fetchIndexHistory,
};
