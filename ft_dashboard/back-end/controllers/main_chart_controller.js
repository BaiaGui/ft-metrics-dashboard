const db = require("../db_conn");
//Define here category questions range -> [initial question, final question]
const INFRASTRUCTURE = [1, 7];
const STUDENT_PARTICIPATION = [8, 14];
const TEACHER_PERFORMANCE = [15, 24];
const OPEN_QUESTIONS = [25, 26];

class MainChartController {
  async findYearsInDB(req, res) {
    try {
      const collection = db.collection("cohorts");
      const uniqueYears = await collection.distinct("ano");
      res.send(uniqueYears);
    } catch (e) {
      console.log("MainChartController::Error getting unique years:" + e);
      res.status(e.code || 500).json({ message: e.message });
    }
  }

  async getIndex(req, res) {
    try {
      let { year, semester } = req.body;
      if (!year || !semester) {
        const error = new Error("Year or Semester not defined");
        error.code = 400;
        throw error;
      }

      let answerProportion = await getAnswerProportionByTime(year, semester);
      let indexInfra = calculateIndexByCategory(answerProportion[0]);
      let indexStudent = calculateIndexByCategory(answerProportion[1]);
      let indexTeacher = calculateIndexByCategory(answerProportion[2]);

      res.send({
        year: year,
        semester: semester,
        indexInfra,
        indexStudent,
        indexTeacher,
      });
    } catch (e) {
      console.log("MainChartController::Error getting index:" + e);
      res.status(e.code || 500).json({ message: e.message });
    }
  }

  async getAllCourses(req, res) {
    try {
      const collection = db.collection("courses");
      const courses = await collection.find({}).toArray();
      console.log(courses);
      res.send(courses);
    } catch (e) {
      console.log("MainChartController::Error getting courses:" + e);
      res.status(e.code || 500).json({ message: e.message });
    }
  }
}

async function getAnswerProportionByTime(year, semester) {
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

  if (!formGroup.length) {
    const error = new Error("Data not found. Verify request values");
    error.code = 400;
    throw error;
  }
  return formGroup;
}

function calculateIndexByCategory(answerProportion) {
  let { count_0, count_1, count_2, count_3, count_4, count_5 } = answerProportion.typeCount;
  let sum = 5 * count_5 + 4 * count_4 + 3 * count_3 + 2 * count_2 + 1 * count_1;
  let validAnswers = count_1 + count_2 + count_3 + count_4 + count_5;
  let index = (sum / validAnswers - 1) / 4;

  return index;
}

module.exports = new MainChartController();
