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
      dataId: course._id,
      description: course.nomeCurso,
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
      dataId: group._id,
      description: group.descrição,
      proportion: proportion,
    });
  }

  return { proportionGroup };
}

async function getSubjectsProportionsByGroup(year, semester, courseId, groupId) {
  const subjects = await answerProportionData.getSubjectsbyGroup(groupId);
  console.log("DISCIPLINAS DO GRUPO " + groupId);
  console.log(subjects);
  let proportionGroup = [];

  for (let subject of subjects) {
    let proportion = await answerProportionData.getSubjectProportion(subject.codDisc, year, semester);
    proportionGroup.push({
      dataId: subject.codDisc,
      description: subject.nome,
      proportion: proportion,
    });
  }

  return { proportionGroup };
}

module.exports = {
  //answerProportions,
  getCourseProportionsByTime,
  getGroupProportionsByCourse,
  getSubjectsProportionsByGroup,
};
