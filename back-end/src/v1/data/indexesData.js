const connectDB = require("../../db_conn");

/**
 * IMPORTANTE!
 * Para calcular o TIPO de resposta (concordo parcialmente, discordo totalmente, ...),
 * a função considera o NÚMERO da resposta. Ou seja, 1 = DT, 2 = DP, ...
 *
 * A query irá agrupar as questões do mesmo GRUPO (EX:  Infraestrutura e Suporte às aulas)
 * e irá contar a quantidade de cada TIPO de resposta do grupo
 * (Ex: 50 respostas Concordo plenamente do grupo Infraestrutura e Suporte às aulas do semestre 2022.2)
 *
 * IMPORTANT!
 * In order to calculate the TYPE of the answer (Strongly disagree, Disagree, ...),
 * the function considers the NUMBER of the answer. For instance: 1 = Strongly Disagree, 2= Disagree
 *
 * The query will group together the questions that belong to the same GROUP and then it will count the total number of each answer TYPE
 * (Ex: 50 'Agree' Answers of the group 'Student Participation' for the 2023.1 semester)
 */

async function getGeneralAnswerProportionByTime(year, semester) {
  //TODO: validate if params are int
  try {
    const db = await connectDB();
    const cohorts = db.collection("disciplinas");
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
            from: "formularios",
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

async function getAnswerProportionByCourse(year, semester, courseId) {
  //TODO: validate if params are int
  try {
    const db = await connectDB();
    const cohorts = db.collection("disciplinas");
    const proportion = await cohorts
      .aggregate([
        {
          $lookup: {
            from: "grupos_disciplinas",
            localField: "codDisc",
            foreignField: "materias",
            as: "result",
          },
        },
        {
          $project: {
            id: 1,
            ano: 1,
            semestre: 1,
            codTurma: 1,
            group: {
              $filter: {
                input: "$result",
                as: "group",
                cond: {
                  $eq: ["$$group.curso_id", courseId],
                },
              },
            },
          },
        },
        {
          $unwind: {
            path: "$group",
            preserveNullAndEmptyArrays: false,
          },
        },
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
            from: "formularios",
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
    if (proportion.length == 0) {
      throw { status: 400, message: "Data not found. Verify request values" };
    }
    return proportion;
  } catch (e) {
    throw e;
  }
}

async function getAnswerProportionBySubGroup(year, semester, groupId) {
  //TODO: validate if params are int
  try {
    const db = await connectDB();
    const cohorts = db.collection("disciplinas");
    const formGroup = await cohorts
      .aggregate([
        {
          $lookup: {
            from: "grupos_disciplinas",
            localField: "codDisc",
            foreignField: "materias",
            as: "result",
          },
        },
        {
          $project: {
            id: 1,
            ano: 1,
            semestre: 1,
            codTurma: 1,
            group: {
              $filter: {
                input: "$result",
                as: "group",
                cond: {
                  $eq: ["$$group._id", groupId],
                },
              },
            },
          },
        },
        {
          $unwind: {
            path: "$group",
            preserveNullAndEmptyArrays: false,
          },
        },
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
            from: "formularios",
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

async function getAnswerProportionBySubject(year, semester, subjectId) {
  //TODO: validate if params are int
  try {
    const db = await connectDB();
    const cohorts = db.collection("disciplinas");
    const formGroup = await cohorts
      .aggregate([
        //stage 1: find cohorts that match requirements
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
            codDisc: subjectId,
          },
        },
        //stage 2: get related form data
        {
          $lookup: {
            from: "formularios",
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
    console.log(formGroup);
    // if (formGroup.length == 0) {
    //   throw { status: 400, message: "Data not found. Verify request values" };
    // }
    return formGroup;
  } catch (e) {
    throw e;
  }
}

module.exports = {
  getGeneralAnswerProportionByTime,
  getAnswerProportionByCourse,
  getAnswerProportionBySubGroup,
  getAnswerProportionBySubject,
};
