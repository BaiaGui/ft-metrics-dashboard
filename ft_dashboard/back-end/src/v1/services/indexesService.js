const indexesData = require("../data/indexesData");
//todo: change this name:
const basicDataData = require("../data/basicDataData");

async function getAllIndexes() {
  let uniqueYears = await basicDataData.findYearsInDB();
  let indexInfra = [];
  let indexStudent = [];
  let indexTeacher = [];
  for (let year of uniqueYears) {
    let yearSemester = year.split(".");
    let index = await getIndex(yearSemester[0], yearSemester[1]);
    indexInfra.push([year, parseFloat(index.indexInfra.toFixed(5))]);
    indexStudent.push([year, parseFloat(index.indexStudent.toFixed(5))]);
    indexTeacher.push([year, parseFloat(index.indexTeacher.toFixed(5))]);
  }
  console.log({
    indexInfra,
    indexStudent,
    indexTeacher,
  });
  return {
    indexInfra,
    indexStudent,
    indexTeacher,
  };
}

async function getCourseIndexes(courseId) {
  let uniqueYears = await basicDataData.findYearsInDB();
  let indexInfra = [];
  let indexStudent = [];
  let indexTeacher = [];
  for (let year of uniqueYears) {
    let yearSemester = year.split(".");
    let index = await getIndex(yearSemester[0], yearSemester[1], courseId);
    indexInfra.push([year, parseFloat(index.indexInfra.toFixed(5))]);
    indexStudent.push([year, parseFloat(index.indexStudent.toFixed(5))]);
    indexTeacher.push([year, parseFloat(index.indexTeacher.toFixed(5))]);
  }
  console.log({
    indexInfra,
    indexStudent,
    indexTeacher,
  });
  return {
    indexInfra,
    indexStudent,
    indexTeacher,
  };
}
async function getSubjectGroupIndexes(courseId, groupId) {
  let uniqueYears = await basicDataData.findYearsInDB();
  let indexInfra = [];
  let indexStudent = [];
  let indexTeacher = [];
  for (let year of uniqueYears) {
    let yearSemester = year.split(".");
    let index = await getIndex(yearSemester[0], yearSemester[1], courseId, groupId);
    indexInfra.push([year, parseFloat(index.indexInfra.toFixed(5))]);
    indexStudent.push([year, parseFloat(index.indexStudent.toFixed(5))]);
    indexTeacher.push([year, parseFloat(index.indexTeacher.toFixed(5))]);
  }
  console.log({
    indexInfra,
    indexStudent,
    indexTeacher,
  });
  return {
    indexInfra,
    indexStudent,
    indexTeacher,
  };
}

//------------------
async function getIndex(year, semester, courseId, subGroup, subject) {
  try {
    let answerProportion;

    // Verifica quais parâmetros estão definidos e ajusta a lógica
    if (year && semester && courseId && subGroup && subject) {
      answerProportion = await indexesData.getAnswerProportionBySubject(year, semester, courseId, subGroup, subject);
    } else if (year && semester && courseId && subGroup) {
      answerProportion = await indexesData.getAnswerProportionBySubGroup(year, semester, courseId, subGroup);
    } else if (year && semester && courseId) {
      answerProportion = await indexesData.getAnswerProportionByCourse(year, semester, courseId);
    } else if (year && semester) {
      answerProportion = await indexesData.getAnswerProportionByTime(year, semester);
    } else {
      throw new Error("Incorrect parameters on getIndex function");
    }

    // Calcula os índices
    const indexInfra = calculateIndex(answerProportion[0]);
    const indexStudent = calculateIndex(answerProportion[1]);
    const indexTeacher = calculateIndex(answerProportion[2]);

    // Monta o resultado
    const indexes = {
      year,
      semester,
      indexInfra,
      indexStudent,
      indexTeacher,
    };

    // Adiciona parâmetros opcionais ao resultado
    if (courseId) indexes.course = courseId;
    if (subGroup) indexes.subGroup = subGroup;
    if (subject) indexes.subject = subject;

    return indexes;
  } catch (e) {
    console.error("Erro ao calcular os índices:", e);
    throw e;
  }
}

function calculateIndex(answerProportion) {
  //TODO: validate argument format
  let { count_0, count_1, count_2, count_3, count_4, count_5 } = answerProportion.typeCount;
  let sum = 5 * count_5 + 4 * count_4 + 3 * count_3 + 2 * count_2 + 1 * count_1;
  let validAnswers = count_1 + count_2 + count_3 + count_4 + count_5;
  let index = (sum / validAnswers - 1) / 4;

  return index;
}

module.exports = {
  getAllIndexes,
  getCourseIndexes,
  getIndex,
  getSubjectGroupIndexes,
};
