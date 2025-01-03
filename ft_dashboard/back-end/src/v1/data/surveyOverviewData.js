const db = require("../../db_conn");

async function findLatestDate() {
  try {
    const collection = db.collection("cohorts");
    //minimalist way - returns a document instead
    //const latestDate = await collection.findOne({}, { sort: { ano: -1, semestre: -1 } });
    const latestDate = await collection
      .aggregate([
        {
          $group: {
            _id: {
              year: "$ano",
              semester: "$semestre",
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
            year: -1,
            semester: -1,
          },
        },
        // {
        //   $project: {
        //     latestDate: {
        //       $concat: [
        //         {
        //           $toString: "$year"
        //         },
        //         ".",
        //         {
        //           $toString: "$semester"
        //         }
        //       ]
        //     }
        //   }
        // }
        {
          $limit: 1,
        },
      ])
      .toArray();
    console.log(latestDate[0]);
    return latestDate[0];
  } catch (e) {
    console.log("SurveyOverview::Error getting latest date:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function findTotalEnrolled(year, semester) {
  try {
    const collection = db.collection("cohorts");
    const totalEnrolled = await collection
      .aggregate([
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
          },
        },
        {
          $group: {
            _id: {
              $concat: [{ $toString: "$ano" }, ".", { $toString: "$semestre" }],
            },
            totalEnrolled: {
              $sum: "$matriculas",
            },
          },
        },
      ])
      .toArray();
    return totalEnrolled[0].totalEnrolled;
  } catch (e) {
    console.log("MainChartController::Error getting total enrolled:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function findTotalRespondents(year, semester) {
  try {
    const collection = db.collection("cohorts");
    const totalRespondents = await collection
      .aggregate([
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
          },
        },
        {
          $lookup: {
            from: "forms",
            localField: "codTurma",
            foreignField: "codTurma",
            as: "forms",
          },
        },
        {
          $project: {
            ano: "$ano",
            semestre: "$semestre",
            respondents: {
              $size: "$forms",
            },
          },
        },
        {
          $group: {
            _id: {
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
            totalRespondents: {
              $sum: "$respondents",
            },
          },
        },
      ])
      .toArray();
    return totalRespondents[0].totalRespondents;
  } catch (e) {
    console.log("SurveyOverview::Error getting total respondents:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function findEnrolledInCourseByTime(year, semester, courseId) {
  try {
    const collection = db.collection("cohorts");
    const totalEnrolled = await collection
      .aggregate([
        {
          $lookup: {
            from: "subject_group",
            localField: "codDisc",
            foreignField: "materias",
            as: "cursoData",
          },
        },
        {
          $match: {
            "ano": parseInt(year),
            "semestre": parseInt(semester),
            "cursoData.curso_id": courseId,
          },
        },
        {
          $group: {
            _id: {
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
            totalEnrolled: {
              $sum: "$matriculas",
            },
          },
        },
      ])
      .toArray();
    return totalEnrolled[0].totalEnrolled;
  } catch (e) {
    console.log("MainChartController::Error getting total enrolled:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

async function findRespondentsInCourseByTime(year, semester, courseId) {
  try {
    const collection = db.collection("cohorts");
    const totalRespondents = await collection
      .aggregate([
        {
          $lookup: {
            from: "subject_group",
            localField: "codDisc",
            foreignField: "materias",
            as: "cursoData",
          },
        },
        {
          $match: {
            "ano": parseInt(year),
            "semestre": parseInt(semester),
            "cursoData.curso_id": courseId,
          },
        },
        {
          $lookup: {
            from: "forms",
            localField: "codTurma",
            foreignField: "codTurma",
            as: "forms",
          },
        },
        {
          $project: {
            ano: "$ano",
            semestre: "$semestre",
            respondents: {
              $size: "$forms",
            },
          },
        },
        {
          $group: {
            _id: {
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
            totalRespondents: {
              $sum: "$respondents",
            },
          },
        },
      ])
      .toArray();
    return totalRespondents[0].totalRespondents;
  } catch (e) {
    console.log("SurveyOverview::Error getting total respondents:" + e);
    res.status(e.code || 500).json({ message: e.message });
  }
}

module.exports = {
  findLatestDate,
  findTotalEnrolled,
  findTotalRespondents,
  findEnrolledInCourseByTime,
  findRespondentsInCourseByTime,
};
