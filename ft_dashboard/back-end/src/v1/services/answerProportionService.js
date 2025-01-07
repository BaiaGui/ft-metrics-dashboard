const answerProportionData = require("../data/answerProportionData");

// async function answerProportions(courseId, year, semester) {
//   const courses = answerProportionData.getAllCourses();
//   courses.forEach((course) => {
//     let proportion = {
//       courseId: course._id,
//       course: course.nomeCurso,
//       proportion: answerProportionData.getCourseProportion(courseId, year, semester),
//     };
//   });

//   return answerProportionData.getCourseProportion(courseId, year, semester);
// }

async function getCourseProportionsByTime(year, semester) {
  const courses = await answerProportionData.getCourses();
  let proportionGroup = [];

  for (let course of courses) {
    let proportion = await answerProportionData.getCourseProportion(course._id, year, semester);
    proportionGroup.push({
      course: course.nomeCurso,
      proportion: proportion,
    });
  }

  return { proportionGroup };
}

async function getGroupProportionsByCourse(year, semester, courseId) {
  const groups = await answerProportionData.getGroupsbyCourse(courseId);
  console.log("GRUPOS DO CURSO " + courseId);
  console.log(groups);
  let proportionGroup = [];

  for (let group of groups) {
    let proportion = await answerProportionData.getGroupProportion(group._id, year, semester);
    proportionGroup.push({
      group: group.descrição,
      proportion: proportion,
    });
  }

  return { proportionGroup };
}

module.exports = {
  //answerProportions,
  getCourseProportionsByTime,
  getGroupProportionsByCourse,
};
