const indexesData = require("../data/indexesData");
//todo: change this name:
const basicDataData = require("../data/basicDataData");

async function fetchHistoryByViewAndId(view, id) {
  const uniqueYears = await basicDataData.findYearsInDB();
  let indexInfra = [];
  let indexStudent = [];
  let indexTeacher = [];

  for (let year of uniqueYears) {
    let yearSemester = year.split(".");
    let index = await fetchIndex(yearSemester[0], yearSemester[1], view, id);
    if (index != null) {
      indexInfra.push([year, parseFloat(index.indexInfra.toFixed(5))]);
      indexStudent.push([year, parseFloat(index.indexStudent.toFixed(5))]);
      indexTeacher.push([year, parseFloat(index.indexTeacher.toFixed(5))]);
    }
  }

  return {
    view,
    id,
    indexInfra,
    indexStudent,
    indexTeacher,
  };
}

//------------------
async function fetchIndex(year, semester, view, id) {
  let answerProportion;
  switch (view) {
    case "general":
      answerProportion = await indexesData.getGeneralAnswerProportionByTime(year, semester);
      break;
    case "course":
      answerProportion = await indexesData.getAnswerProportionByCourse(year, semester, id);
      break;
    case "subjectGroup":
      answerProportion = await indexesData.getAnswerProportionBySubGroup(year, semester, id);
      break;
    case "subject":
      answerProportion = await indexesData.getAnswerProportionBySubject(year, semester, id);

      break;
    default:
      throw { status: 400, message: `IndexesService::Invalid view value '${view}'` };
  }

  if (answerProportion.length != 0) {
    const indexInfra = calculateIndexByAnswerProportion(answerProportion[0]);
    const indexStudent = calculateIndexByAnswerProportion(answerProportion[1]);
    const indexTeacher = calculateIndexByAnswerProportion(answerProportion[2]);

    const indexes = {
      year,
      semester,
      indexInfra,
      indexStudent,
      indexTeacher,
    };

    // Adiciona parâmetros opcionais ao resultado
    if (view == "course") indexes.courseId = id;
    if (view == "subjectGroup") indexes.subjectGroupId = id;
    if (view == "subject") indexes.subjectId = id;

    return indexes;
  } else {
    return null;
  }
}

function calculateIndexByAnswerProportion(answerProportion) {
  //TODO: validate argument format
  let { count_0, count_1, count_2, count_3, count_4, count_5 } = answerProportion.typeCount;
  let sum = 5 * count_5 + 4 * count_4 + 3 * count_3 + 2 * count_2 + 1 * count_1;
  let validAnswers = count_1 + count_2 + count_3 + count_4 + count_5;
  let calculatedIndex = (sum / validAnswers - 1) / 4;

  return calculatedIndex;
}
//--------------------------------------------------------------------------------------------------------------------

module.exports = {
  fetchHistoryByViewAndId,
  fetchIndex,
};
