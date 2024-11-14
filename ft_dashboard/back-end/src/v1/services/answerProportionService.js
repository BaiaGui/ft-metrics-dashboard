const answerProportionData = require("../data/answerProportionData");

async function answerProportions(courseId, year, semester) {
  const courses = answerProportionData.getAllCourses();
  courses.forEach((course) => {
    let proportion = {
      course: course.nomeCurso,
      proportion: answerProportionData.getCourseProportion(courseId, year, semester),
    };
  });

  return answerProportionData.getCourseProportion(courseId, year, semester);
}

async function allAnswerProportions() {
  let year = 2023;
  let semester = 2;
  const courses = await answerProportionData.getAllCourses();
  let proportionGroup = [];

  for (let course of courses) {
    console.log("course:" + course);
    let proportion = await answerProportionData.getCourseProportion(course._id, year, semester);
    proportionGroup.push({
      course: course.nomeCurso,
      proportion: proportion,
    });
    console.log("proportion:" + proportion);
  }

  return { proportionGroup };
}

module.exports = {
  answerProportions,
  allAnswerProportions,
};
