const db = require("../db_conn");
//Define here category questions range -> [initial question, final question]

const INFRASTRUCTURE = [1, 7];
const STUDENT_PARTICIPATION = [8, 14];
const TEACHER_PERFORMANCE = [15, 24];
const OPEN_QUESTIONS = [25, 26];

class MainChartController {
  async findYearsInDB(req, res) {
    const collection = db.collection("cohorts");
    const uniqueYears = await collection.distinct("ano");
    res.send(uniqueYears);
  }

  async getIndex(req, res) {
    //category is defined here
    let year = 2022;
    let semester = 2;
    let filteredForms = await getFormsByTime(year, semester);
    //let answerProportion = getAnswerProportion(filteredForms);
    //let index = calculateIndexByCategory(filteredForms, 1);

    res.send(filteredForms);
  }
}

async function getFormsByTime(year, semester) {
  try {
    const cohorts = db.collection("cohorts");
    const formGroup = await cohorts
      .aggregate([
        //stage 1: find cohorts that match requirements
        {
          $match: {
            ano: year,
            semestre: semester,
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
        //TEPORARY STAGES: LIMITING NUMBER OF DOCUMENTS TO VERIFY COUNT ALGORITHM
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
            contagem: {
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

    return formGroup;
  } catch (e) {
    console.log("Main Chart Controller: Error retrieving forms:" + e);
  }
}

/**
 * IMPORTANTE!
 * Para calcular o TIPO de resposta (concordo parcialmente, discordo totalmente, ...),
 * a função considera o NÚMERO da resposta. Ou seja, 1 = DT, 2 = DP, ...
 *
 */
function getAnswerProportion(forms) {
  let answerProportion = [0, 0, 0, 0, 0, 0];
  for (let i = 0; i < forms.length; i++) {
    for (let j = 0; j < forms[i].questoes.length - 2; j++) {
      let answer = forms[i].questoes[j].resposta;
      answerProportion[answer]++;
    }
  }
  return answerProportion;
}

function calculateIndexByCategory(formData, category) {}

module.exports = new MainChartController();

const query = [
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
  //TEPORARY STAGES: LIMITING NUMBER OF DOCUMENTS TO VERIFY COUNT ALGORITHM
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
    $unwind:
      /**
       * path: Path to the array field.
       * includeArrayIndex: Optional name for index.
       * preserveNullAndEmptyArrays: Optional
       *   toggle to unwind null and empty values.
       */
      {
        path: "$questoes",
      },
  },
  {
    $bucket:
      /**
       * groupBy: The expression to group by.
       * boundaries: An array of the lower boundaries for each bucket.
       * default: The bucket name for documents that do not fall within the specified boundaries
       * output: {
       *   outputN: Optional. The output object may contain a single or numerous field names used to accumulate values per bucket.
       * }
       */
      {
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
    $project:
      /**
       * _id: The id of the group.
       * fieldN: The first field name.
       */
      {
        _id: "$_id",
        contagem: {
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
];
