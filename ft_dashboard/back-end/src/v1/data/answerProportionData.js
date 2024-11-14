const db = require("../../db_conn");

async function getAllCourses() {
  try {
    const collection = db.collection("courses");
    const courses = await collection.find({}).toArray();
    return courses;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

async function getCourseProportion(course, year, semester) {
  try {
    const collection = db.collection("cohorts");
    const courseProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "courses",
            localField: "codDisc",
            foreignField: "cod_disciplinas",
            as: "curso",
          },
        },
        {
          $match: {
            "curso._id": course,
            "ano": year,
            "semestre": semester,
          },
        },
        {
          $project: {
            codTurma: 1,
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
          $unwind: {
            path: "$forms",
          },
        },
        {
          $replaceRoot: {
            newRoot: "$forms",
          },
        },
        {
          $unwind: {
            path: "$questoes",
          },
        },
        {
          $bucket: {
            groupBy: {
              $toInt: "$questoes.numero_pergunta",
            },
            boundaries: [1, 8, 15, 25],
            default: "Others",
            output: {
              category_answers: {
                $push: "$questoes.resposta",
              },
            },
          },
        },
        {
          $project: {
            _id: "$_id",
            typeCount: {
              $reduce: {
                input: "$category_answers",
                initialValue: {
                  count_0: 0,
                  count_1: 0,
                  count_2: 0,
                  count_3: 0,
                  count_4: 0,
                  count_5: 0,
                },
                in: {
                  count_0: {
                    $cond: [
                      {
                        $eq: ["$$this", "0"],
                      },
                      {
                        $add: ["$$value.count_0", 1],
                      },
                      "$$value.count_0",
                    ],
                  },
                  count_1: {
                    $cond: [
                      {
                        $eq: ["$$this", "1"],
                      },
                      {
                        $add: ["$$value.count_1", 1],
                      },
                      "$$value.count_1",
                    ],
                  },
                  count_2: {
                    $cond: [
                      {
                        $eq: ["$$this", "2"],
                      },
                      {
                        $add: ["$$value.count_2", 1],
                      },
                      "$$value.count_2",
                    ],
                  },
                  count_3: {
                    $cond: [
                      {
                        $eq: ["$$this", "3"],
                      },
                      {
                        $add: ["$$value.count_3", 1],
                      },
                      "$$value.count_3",
                    ],
                  },
                  count_4: {
                    $cond: [
                      {
                        $eq: ["$$this", "4"],
                      },
                      {
                        $add: ["$$value.count_4", 1],
                      },
                      "$$value.count_4",
                    ],
                  },
                  count_5: {
                    $cond: [
                      {
                        $eq: ["$$this", "5"],
                      },
                      {
                        $add: ["$$value.count_5", 1],
                      },
                      "$$value.count_5",
                    ],
                  },
                },
              },
            },
          },
        },
      ])
      .toArray();

    console.log("coursProp:" + courseProportion);
    return courseProportion;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

module.exports = {
  getAllCourses,
  getCourseProportion,
};
