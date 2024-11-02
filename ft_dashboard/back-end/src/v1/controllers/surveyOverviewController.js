const db = require("../../db_conn");

async function findLatestDate(req, res) {
  try {
    const collection = db.collection("cohorts");
    //minimalist way
    //const latestDate = await collection.findOne({}, { sort: { ano: -1, semestre: -1 } });
    const latestDate = await collection
      .aggregate([
        {
          $group: {
            _id: {
              ano: "$ano",
              semestre: "$semestre",
            },
          },
        },
        {
          $replaceRoot: {
            newRoot: "$_id",
          },
        },
        {
          $sort: {
            ano: -1,
            semestre: -1,
          },
        },
        {
          $project: {
            latestDate: {
              $concat: [
                {
                  $toString: "$ano",
                },
                ".",
                {
                  $toString: "$semestre",
                },
              ],
            },
          },
        },
        {
          $limit: 1,
        },
      ])
      .toArray();
    res.send(latestDate[0]);
  } catch (e) {
    console.log("MainChartController::Error getting latest date:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function getInfo(req, res) {
  //get most recent year and semester of the db (ok)
  //getNumber of enrolled in cohorts -> pesquisa mais recente
  //getNumber of forms -> most recent
  //calculate rate (forms/enrolled)
  //calculateIndex(allFormsEver) -> Most recent

  res.send({
    num_respondents: 1,
    num_enrolled: 1,
    participation_rate: "1%",
    general_index: 0.8,
  });
}
