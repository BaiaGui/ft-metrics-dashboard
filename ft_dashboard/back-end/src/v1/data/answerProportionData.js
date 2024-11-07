const db = require("../../db_conn");

async function getAllCourses(req, res) {
  try {
    const collection = db.collection("courses");
    const courses = await collection.find({}).toArray();

    return courses;
  } catch (e) {
    throw { status: 400, message: e };
  }
}

async function getCourseProportion(course) {
  try {
    const collection = db.collection("courses");
  } catch (e) {
    throw { status: 400, message: e };
  }
}

module.exports = {
  getAllCourses,
};
