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

module.exports = {
  getAllCourses,
  getCourseProportion,
};
