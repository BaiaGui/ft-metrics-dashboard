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
    let { year, semester } = req.body;
    if (!year || !semester) {
      throw { status: 400, message: "Year or Semester not defined" };
    }
    const indexes = await indexesService.getIndex(year, semester);
    res.send(indexes);
  } catch (e) {
    console.log("Indexes::Error getting index:" + e.message);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  getIndex,
};
