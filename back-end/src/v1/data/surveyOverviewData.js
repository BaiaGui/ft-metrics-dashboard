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
    return latestDate[0];
  } catch (e) {
    console.log("SurveyOverviewData:: error while fetching the latest date in the database" + e);
    throw { status: 500 };
  }
}
//general------------------------------------------------------------------------
async function countEnrolledInGeneralByPeriod(year, semester) {
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
    console.log("SurveyOverviewData:: error on countEnrolledInGeneralByPeriod" + e);
    throw { status: 500 };
  }
}

async function countGeneralResponsesByPeriod(year, semester) {
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
    console.log("SurveyOverviewData:: error on countGeneralResponsesByPeriod" + e);
    throw { status: 500 };
  }
}
//courses------------------------------------------------------------------------
async function countEnrolledInCourseByPeriod(year, semester, courseId) {
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
    console.log("SurveyOverviewData:: error on countEnrolledInCourseByPeriod" + e);
    throw { status: 500 };
  }
}

async function countResponsesForCourseByPeriod(year, semester, courseId) {
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
    console.log("SurveyOverviewData:: error on countResponsesForCourseByPeriod" + e);
    throw { status: 500 };
  }
}
//subject group------------------------------------------------------------------
async function countEnrolledInGroupByPeriod(year, semester, groupId) {
  try {
    const collection = db.collection("cohorts");
    const totalEnrolled = await collection
      .aggregate([
        {
          $lookup: {
            from: "subject_group",
            localField: "codDisc",
            foreignField: "materias",
            as: "groupData",
          },
        },
        {
          $match: {
            "ano": parseInt(year),
            "semestre": parseInt(semester),
            "groupData._id": groupId,
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
    console.log("SurveyOverviewData:: error on countEnrolledInGroupByPeriod" + e);
    throw { status: 500 };
  }
}

async function countResponsesForGroupByPeriod(year, semester, groupId) {
  try {
    const collection = db.collection("cohorts");
    const totalRespondents = await collection
      .aggregate([
        {
          $lookup: {
            from: "subject_group",
            localField: "codDisc",
            foreignField: "materias",
            as: "groupData",
          },
        },
        {
          $match: {
            "ano": parseInt(year),
            "semestre": parseInt(semester),
            "groupData.curso_id": groupId,
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
    console.log("SurveyOverviewData:: error on countResponsesForGroupByPeriod" + e);
    throw { status: 500 };
  }
}
//subject------------------------------------------------------------------------
async function countEnrolledInSubjectByPeriod(year, semester, subjectId) {
  try {
    const collection = db.collection("cohorts");
    const totalEnrolled = await collection
      .aggregate([
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
            codDisc: subjectId,
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
    console.log("SurveyOverviewData:: error on countEnrolledInSubjectByPeriod" + e);
    throw { status: 500 };
  }
}

async function countResponsesForSubjectByPeriod(year, semester, subjectId) {
  try {
    const collection = db.collection("cohorts");
    const totalRespondents = await collection
      .aggregate([
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
            codDisc: subjectId,
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
    console.log("SurveyOverviewData:: error on countResponsesForSubjectByPeriod" + e);
    throw { status: 500 };
  }
}

module.exports = {
  findLatestDate,
  countEnrolledInGeneralByPeriod,
  countGeneralResponsesByPeriod,
  countEnrolledInCourseByPeriod,
  countResponsesForCourseByPeriod,
  countEnrolledInGroupByPeriod,
  countResponsesForGroupByPeriod,
  countEnrolledInSubjectByPeriod,
  countResponsesForSubjectByPeriod,
};
