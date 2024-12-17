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

module.exports = {
  getIndex,
};
