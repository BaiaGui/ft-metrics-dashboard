const connectDB = require("../../db_conn");

async function getCourses() {
  try {
    const db = await connectDB();
    const collection = db.collection("cursos");
    const courses = await collection.find({}).toArray();
    return courses;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

async function getCourseProportion(year, semester, courseId) {
  try {
    const db = await connectDB();
    const collection = db.collection("turmas");
    const courseProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "cursos",
            localField: "codDisc",
            foreignField: "cod_disciplinas",
            as: "curso",
          },
        },
        {
          $match: {
            "curso._id": courseId,
            "ano": parseInt(year),
            "semestre": parseInt(semester),
          },
        },
        {
          $project: {
            codTurma: 1,
          },
        },
        {
          $lookup: {
            from: "formularios",
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
          $group:
            /**
             * _id: The id of the group.
             * fieldN: The first field name.
             */
            {
              _id: "$questoes.resposta",
              count: {
                $sum: 1,
              },
            },
        },
        {
          $match: {
            $or: [
              {
                _id: "0",
              },
              {
                _id: "1",
              },
              {
                _id: "2",
              },
              {
                _id: "3",
              },
              {
                _id: "4",
              },
              {
                _id: "5",
              },
            ],
          },
        },
        {
          $sort: {
            _id: 1,
          },
        },
      ])
      .toArray();

    return courseProportion;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

/*Subject Group Anwser Proportion----------------------------------------------------------------------------------------------------- */

async function getGroupsbyCourse(courseId) {
  try {
    const db = await connectDB();
    const collection = db.collection("grupos_disciplinas");
    const groups = await collection.find({ curso_id: courseId }).sort({ _id: 1 }).toArray();
    return groups;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

/*Obs: 
Algumas matérias estão presentes em vários cursos simultaneamente.
A query da função busca as turmas de uma matéria dentro do grupo de matéria de um curso X.
Algumas turmas são de uma matéria que existe no curso X mas não são do curso X.
A query não consegue diferenciar turmas da mesma matéria mas de cursos diferentes.
Ou seja, o resultado da proporção pode retornar opiniões que não são exclusivas de um curso.
Para um resultado exclusivo talvez fosse necessário marcar com uma flag para qual curso aquela turma é direcionada.
*/
async function getGroupProportion(groupId, year, semester) {
  try {
    const db = await connectDB();
    const collection = db.collection("turmas");
    const groupProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "grupos_disciplinas",
            localField: "codDisc",
            foreignField: "materias",
            as: "grupos",
          },
        },
        {
          $match: {
            "grupos._id": groupId,
            "ano": parseInt(year),
            "semestre": parseInt(semester),
          },
        },
        {
          $project: {
            codTurma: 1,
          },
        },
        {
          $lookup: {
            from: "formularios",
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
          $group: {
            _id: "$questoes.resposta",
            count: {
              $sum: 1,
            },
          },
        },
        {
          $facet: {
            counts: [
              {
                $match: {},
              },
            ],
            fixed: [
              {
                $project: {
                  responses: [
                    {
                      _id: "0",
                      count: 0,
                    },
                    {
                      _id: "1",
                      count: 0,
                    },
                    {
                      _id: "2",
                      count: 0,
                    },
                    {
                      _id: "3",
                      count: 0,
                    },
                    {
                      _id: "4",
                      count: 0,
                    },
                    {
                      _id: "5",
                      count: 0,
                    },
                  ],
                },
              },
              {
                $unwind: "$responses",
              },
              {
                $replaceRoot: {
                  newRoot: "$responses",
                },
              },
            ],
          },
        },
        {
          $project: {
            combined: {
              $concatArrays: ["$counts", "$fixed"],
            },
          },
        },
        {
          $unwind: "$combined",
        },
        {
          $replaceRoot: {
            newRoot: "$combined",
          },
        },
        {
          $group: {
            _id: "$_id",
            count: {
              $max: "$count",
            },
          },
        },
        {
          $sort: {
            _id: 1,
          },
        },
        {
          $match: {
            $or: [
              {
                _id: "0",
              },
              {
                _id: "1",
              },
              {
                _id: "2",
              },
              {
                _id: "3",
              },
              {
                _id: "4",
              },
              {
                _id: "5",
              },
            ],
          },
        },
      ])
      .toArray();

    return groupProportion;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

//Subject-------------------------------------------------------
async function getSubjectsbyGroup(groupId, year, semester) {
  try {
    const db = await connectDB();
    const collection = db.collection("grupos_disciplinas");
    const subjects = await collection
      .aggregate([
        {
          $lookup: {
            from: "disciplinas",
            localField: "materias",
            foreignField: "codDisc",
            as: "matches",
          },
        },
        {
          $match: {
            _id: groupId,
          },
        },
        {
          $unwind: {
            path: "$matches",
          },
        },
        {
          $replaceRoot: {
            newRoot: "$matches",
          },
        },
        {
          $lookup: {
            from: "turmas",
            localField: "codDisc",
            foreignField: "codDisc",
            as: "turmas",
          },
        },
        {
          $match: {
            "turmas.ano": parseInt(year),
            "turmas.semestre": parseInt(semester),
          },
        },
      ])
      .toArray();
    return subjects;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

async function getSubjectProportion(year, semester, subjectId) {
  try {
    const db = await connectDB();
    const collection = db.collection("turmas");
    const groupProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "disciplinas",
            localField: "codDisc",
            foreignField: "codDisc",
            as: "dadosMateria",
          },
        },
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
            codDisc: subjectId,
          },
        },
        {
          $project: {
            codTurma: 1,
          },
        },
        {
          $lookup: {
            from: "formularios",
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
          $group: {
            _id: "$questoes.resposta",
            count: {
              $sum: 1,
            },
          },
        },
        {
          $facet: {
            counts: [
              {
                $match: {},
              },
            ],
            fixed: [
              {
                $project: {
                  responses: [
                    {
                      _id: "0",
                      count: 0,
                    },
                    {
                      _id: "1",
                      count: 0,
                    },
                    {
                      _id: "2",
                      count: 0,
                    },
                    {
                      _id: "3",
                      count: 0,
                    },
                    {
                      _id: "4",
                      count: 0,
                    },
                    {
                      _id: "5",
                      count: 0,
                    },
                  ],
                },
              },
              {
                $unwind: "$responses",
              },
              {
                $replaceRoot: {
                  newRoot: "$responses",
                },
              },
            ],
          },
        },
        {
          $project: {
            combined: {
              $concatArrays: ["$counts", "$fixed"],
            },
          },
        },
        {
          $unwind: "$combined",
        },
        {
          $replaceRoot: {
            newRoot: "$combined",
          },
        },
        {
          $group: {
            _id: "$_id",
            count: {
              $max: "$count",
            },
          },
        },
        {
          $sort: {
            _id: 1,
          },
        },
        {
          $match: {
            $or: [
              {
                _id: "0",
              },
              {
                _id: "1",
              },
              {
                _id: "2",
              },
              {
                _id: "3",
              },
              {
                _id: "4",
              },
              {
                _id: "5",
              },
            ],
          },
        },
      ])
      .toArray();

    return groupProportion;
  } catch (e) {
    throw { status: 400, message: "answerProportionData:" + e };
  }
}
//--------------------------------------------------------------

async function getQuestionsProportionOfSubject(year, semester, subjectId) {
  try {
    const db = await connectDB();
    const collection = db.collection("turmas");
    const questionProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "disciplinas",
            localField: "codDisc",
            foreignField: "codDisc",
            as: "dadosMateria",
          },
        },
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
            codDisc: subjectId,
          },
        },
        {
          $project: {
            codTurma: 1,
          },
        },
        {
          $lookup: {
            from: "formularios",
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
          $group: {
            _id: "$questoes.numero_pergunta",
            total: {
              $sum: 1,
            },
            count0: {
              $sum: {
                $cond: [
                  {
                    $eq: ["$questoes.resposta", "0"],
                  },
                  1,
                  0,
                ],
              },
            },
            count1: {
              $sum: {
                $cond: [
                  {
                    $eq: ["$questoes.resposta", "1"],
                  },
                  1,
                  0,
                ],
              },
            },
            count2: {
              $sum: {
                $cond: [
                  {
                    $eq: ["$questoes.resposta", "2"],
                  },
                  1,
                  0,
                ],
              },
            },
            count3: {
              $sum: {
                $cond: [
                  {
                    $eq: ["$questoes.resposta", "3"],
                  },
                  1,
                  0,
                ],
              },
            },
            count4: {
              $sum: {
                $cond: [
                  {
                    $eq: ["$questoes.resposta", "4"],
                  },
                  1,
                  0,
                ],
              },
            },
            count5: {
              $sum: {
                $cond: [
                  {
                    $eq: ["$questoes.resposta", "5"],
                  },
                  1,
                  0,
                ],
              },
            },
          },
        },
        {
          $lookup: {
            from: "questoes_formulario",
            localField: "_id",
            foreignField: "_id",
            as: "question",
          },
        },
        {
          $addFields: {
            id: {
              $toInt: "$_id",
            },
            description: {
              $first: "$question.enunciado",
            },
          },
        },
        {
          $project: {
            _id: 0,
            id: 1,
            description: 1,
            proportion: [
              {
                _id: "0",
                count: "$count0",
              },
              {
                _id: "1",
                count: "$count1",
              },
              {
                _id: "2",
                count: "$count2",
              },
              {
                _id: "3",
                count: "$count3",
              },
              {
                _id: "4",
                count: "$count4",
              },
              {
                _id: "5",
                count: "$count5",
              },
            ],
          },
        },
        {
          $sort: {
            id: 1,
          },
        },
        {
          $addFields: {
            id: {
              $toString: "$id",
            },
          },
        },
        {
          $match: {
            id: {
              $nin: ["5", "6", "25", "26"],
            },
          },
        },
      ])
      .toArray();
    console.log(questionProportion);
    return questionProportion;
  } catch (e) {}
}

async function fetchComments(year, semester, subjectId) {
  try {
    const db = await connectDB();
    const collection = db.collection("turmas");
    const subjectComments = await collection
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
            from: "formularios",
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
          $match: {
            "questoes.numero_pergunta": {
              $in: ["25", "26"],
            },
            "questoes.resposta": {
              $ne: "",
            },
          },
        },
        {
          $group: {
            _id: null,
            question25: {
              $push: {
                $cond: [
                  {
                    $eq: ["$questoes.numero_pergunta", "25"],
                  },
                  "$questoes.resposta",
                  "$$REMOVE",
                ],
              },
            },
            question26: {
              $push: {
                $cond: [
                  {
                    $eq: ["$questoes.numero_pergunta", "26"],
                  },
                  "$questoes.resposta",
                  "$$REMOVE",
                ],
              },
            },
          },
        },
        {
          $project: {
            _id: 0,
          },
        },
      ])
      .toArray();
    console.log(subjectComments);
    if (subjectComments.length == 0) {
      return { question25: [], question26: [] };
    }
    return subjectComments[0];
  } catch (e) {
    throw { status: 400, message: "answerProportionData:" + e };
  }
}

module.exports = {
  getCourses,
  getCourseProportion,
  getGroupsbyCourse,
  getGroupProportion,
  getSubjectsbyGroup,
  getSubjectProportion,
  fetchComments,
  getQuestionsProportionOfSubject,
};
