const connectDB = require("../../db_conn");

async function findYearsInDB() {
  try {
    const db = await connectDB();
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
            uniqueTime: {
              $sortArray: {
                input: "$uniqueTime",
                sortBy: 1,
              },
            },
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
  findYearsInDB,
};
