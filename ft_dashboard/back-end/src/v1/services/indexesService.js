const indexesData = require("../data/indexesData");

async function getAllIndexes() {
  let uniqueYears = await indexesData.findYearsInDB();
  let indexInfra = [];
  let indexStudent = [];
  let indexTeacher = [];
  for (let year of uniqueYears) {
    let yearSemester = year.split(".");
    let index = await getIndex(yearSemester[0], yearSemester[1]);
    console.log(index);
    indexInfra.push([year, index.indexInfra.toFixed(2)]);
    indexStudent.push([year, index.indexInfra.toFixed(2)]);
    indexTeacher.push([year, index.indexInfra.toFixed(2)]);
  }

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
};
