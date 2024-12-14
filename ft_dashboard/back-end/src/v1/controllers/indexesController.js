const indexesService = require("../services/indexesService");

// async function findYearsInDB(req, res) {
//   try {
//     const uniqueYears = await indexesService.findYearsInDB();
//     res.send(uniqueYears);
//   } catch (e) {
//     console.log("Indexes::Error getting years in DB:" + e);
//     res.status(e.status || 500).json({ message: e.message || e });
//   }
// }

async function getIndex(req, res) {
  try {
    const indexes = await indexesService.getAllIndexes();
    res.send(indexes);
  } catch (e) {
    console.log("Indexes::Error getting index:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  getIndex,
};
