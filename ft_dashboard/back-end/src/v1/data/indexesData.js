const db = require("../../db_conn");

async function getAnswerProportionByTime(year, semester) {
  //TODO: validate if params are int
  try {
    let query = {
      year: year,
      semester: semester,
    };
    //if (course) query.course = course;

    const cohorts = db.collection("cohorts");
    const formGroup = await cohorts
      .aggregate([
        //stage 1: find cohorts that match requirements
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
          },
        },
        //stage 2: get related form data
        {
          $lookup: {
            from: "forms",
            localField: "codTurma",
            foreignField: "codTurma",
            as: "form",
          },
        },
        //stage 3: filter properties
        {
          $project: {
            codTurma: 1,
            ano: 1,
            semestre: 1,
            form: 1,
          },
        },
        {
          $unwind: {
            path: "$form",
          },
        },
        {
          $replaceRoot: {
            newRoot: "$form",
          },
        },
        {
          $unwind: {
            path: "$questoes",
          },
        },
        /**
         * IMPORTANTE!
         * Para calcular o TIPO de resposta (concordo parcialmente, discordo totalmente, ...),
         * a função considera o NÚMERO da resposta. Ou seja, 1 = DT, 2 = DP, ...
         *
         */
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
    if (formGroup.length == 0) {
      throw { status: 400, message: "Data not found. Verify request values" };
    }
    return formGroup;
  } catch (e) {
    throw e;
  }
}

async function findYearsInDB() {
  try {
    const collection = db.collection("cohorts");
    const uniqueYears = await collection
      .aggregate([
        {
          $project: {
            _id: 0,
            uniqueYears: {
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
          $group: {
            _id: null,
            uniqueTime: {
              $addToSet: "$uniqueYears",
            },
          },
        },
        {
          $project: {
            _id: 0,
            uniqueTime: 1,
          },
        },
      ])
      .toArray();
    //returns an array of 'year.semester'
    return uniqueYears[0].uniqueTime;
  } catch (e) {
    throw { status: 400, message: e.message };
  }
}

module.exports = {
  getAnswerProportionByTime,
  findYearsInDB,
};

/* QUERY GET INDEX BY COURSE, YEAR AND SEMESTER
[
  {
    $lookup:

      {
        from: "subject_group",
        localField: "codDisc",
        foreignField: "materias",
        as: "result"
      }
  },
  {
    $project:
      {
        id: 1,
        ano: 1,
        semestre: 1,
        codTurma: 1,
        group: {
          $filter: {
            input: "$result",
            as: "group",
            cond: {
              $eq: ["$$group.curso_id", "0"]
            }
          }
        }
      }
  },
  {
    $unwind:

      {
        path: "$group",
        preserveNullAndEmptyArrays: false
      }
  },
  //stage 1: find cohorts that match requirements
  {
    $match: {
      ano: 2022,
      semestre: 02
    }
  },
  //stage 2: get related form data
  {
    $lookup: {
      from: "forms",
      localField: "codTurma",
      foreignField: "codTurma",
      as: "form"
    }
  },
  //stage 3: filter properties
  {
    $project: {
      codTurma: 1,
      ano: 1,
      semestre: 1,
      form: 1
    }
  },
  {
    $unwind: {
      path: "$form"
    }
  },
  {
    $replaceRoot: {
      newRoot: "$form"
    }
  },
  {
    $unwind: {
      path: "$questoes"
    }
  },
 {
    $bucket: {
      groupBy: {
        $toInt: "$questoes.numero_pergunta"
      },
      boundaries: [1, 8, 15, 25],
      default: "Others",
      output: {
        category_answers: {
          $push: "$questoes.resposta"
        }
      }
    }
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
            count_5: 0
          },
          in: {
            count_0: {
              $cond: [
                {
                  $eq: ["$$this", "0"]
                },
                {
                  $add: ["$$value.count_0", 1]
                },
                "$$value.count_0"
              ]
            },
            count_1: {
              $cond: [
                {
                  $eq: ["$$this", "1"]
                },
                {
                  $add: ["$$value.count_1", 1]
                },
                "$$value.count_1"
              ]
            },
            count_2: {
              $cond: [
                {
                  $eq: ["$$this", "2"]
                },
                {
                  $add: ["$$value.count_2", 1]
                },
                "$$value.count_2"
              ]
            },
            count_3: {
              $cond: [
                {
                  $eq: ["$$this", "3"]
                },
                {
                  $add: ["$$value.count_3", 1]
                },
                "$$value.count_3"
              ]
            },
            count_4: {
              $cond: [
                {
                  $eq: ["$$this", "4"]
                },
                {
                  $add: ["$$value.count_4", 1]
                },
                "$$value.count_4"
              ]
            },
            count_5: {
              $cond: [
                {
                  $eq: ["$$this", "5"]
                },
                {
                  $add: ["$$value.count_5", 1]
                },
                "$$value.count_5"
              ]
            }
          }
        }
      }
    }
  }
]
*/
