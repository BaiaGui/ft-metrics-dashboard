const answerProportionData = require("../data/answerProportionData");

async function answerProportions(courseId, year, semester) {
  const courses = answerProportionData.getAllCourses();
  courses.forEach((course) => {
    let proportion = {
      courseId: course._id,
      course: course.nomeCurso,
      proportion: answerProportionData.getCourseProportion(courseId, year, semester),
    };
  });

  return answerProportionData.getCourseProportion(courseId, year, semester);
}

async function allAnswerProportions(year, semester) {
  const courses = await answerProportionData.getAllCourses();
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

module.exports = {
  answerProportions,
  allAnswerProportions,
};
