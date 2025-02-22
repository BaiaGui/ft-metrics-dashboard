const indexesService = require("../services/indexesService");

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
  fetchIndexHistory,
};
