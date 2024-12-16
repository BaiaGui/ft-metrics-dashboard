const basicDataService = require("../services/basicDataService");

async function findYearsInDB(req, res) {
  try {
    const uniqueYears = await basicDataService.findYearsInDB();
    res.send(uniqueYears);
  } catch (e) {
    console.log("Indexes::Error getting years in DB:" + e);
    res.status(e.status || 500).json({ message: e.message || e });
  }
}

module.exports = {
  findYearsInDB,
};
