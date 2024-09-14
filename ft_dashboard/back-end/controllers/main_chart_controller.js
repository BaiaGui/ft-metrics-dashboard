const db = require("../db_conn");

class MainChartController {
  async findYearsInDB(req, res) {
    const collection = db.collection("cohorts");
    const uniqueYears = await collection.distinct("ano");
    res.send(uniqueYears);
  }
}

module.exports = new MainChartController();
