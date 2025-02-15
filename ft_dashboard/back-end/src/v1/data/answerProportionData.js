const db = require("../../db_conn");

async function getCourses() {
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

    console.log("coursProp:" + courseProportion);
    return courseProportion;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

/*Subject Group Anwser Proportion----------------------------------------------------------------------------------------------------- */

async function getGroupsbyCourse(courseId) {
  try {
    const collection = db.collection("subject_group");
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
    const collection = db.collection("cohorts");
    const groupProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "subject_group",
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

//-------------------------------------------------------
async function getSubjectsbyGroup(groupId) {
  try {
    const collection = db.collection("subject_group");
    const subjects = await collection
      .aggregate([
        {
          $lookup: {
            from: "subjects",
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
      ])
      .toArray();
    return subjects;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

async function getSubjectProportion(subjectCode, year, semester) {
  try {
    const collection = db.collection("cohorts");
    const groupProportion = await collection
      .aggregate([
        {
          $lookup: {
            from: "subjects",
            localField: "codDisc",
            foreignField: "codDisc",
            as: "dadosMateria",
          },
        },
        {
          $match: {
            ano: parseInt(year),
            semestre: parseInt(semester),
            codDisc: subjectCode,
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
          $group: {
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

    return groupProportion;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

module.exports = {
  getCourses,
  getCourseProportion,
  getGroupsbyCourse,
  getGroupProportion,
  getSubjectsbyGroup,
  getSubjectProportion,
};
