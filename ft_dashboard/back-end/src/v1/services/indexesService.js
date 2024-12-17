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

async function getIndex(year, semester) {
  try {
    let answerProportion = await indexesData.getAnswerProportionByTime(year, semester);
    let indexInfra = calculateIndex(answerProportion[0]);
    let indexStudent = calculateIndex(answerProportion[1]);
    let indexTeacher = calculateIndex(answerProportion[2]);

    let indexes = {
      year: year,
      semester: semester,
      indexInfra,
      indexStudent,
      indexTeacher,
    };

    //if (course) indexes.course = course;

    return indexes;
  } catch (e) {
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
  getIndex,
};
