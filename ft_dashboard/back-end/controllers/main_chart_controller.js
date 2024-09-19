const db = require("../db_conn");

class MainChartController {
  async findYearsInDB(req, res) {
    const collection = db.collection("cohorts");
    const uniqueYears = await collection.distinct("ano");
    res.send(uniqueYears);
  }

  async getIndex(req, res) {
    //category is defined here
    let year = 2022;
    let semester = 2;
    let filteredForms = await filterForms(year, semester);
    let index = calculateIndexByCategory(filteredForms, 1);

    res.send(index);
  }
}

module.exports = new MainChartController();

//function that redirect the correct function call based on the arguments
function filterForms(year, semester, course, subjectGroup, subject) {
  let forms = "";
  if (year && semester) {
    forms = getFormsByTime(year, semester);
  }
  if (course) {
  }
  if (subjectGroup) {
  }
  if (subject) {
  }

  return forms;
}

async function getFormsByTime(year, semester) {
  try {
    const cohorts = db.collection("cohorts");
    const filteredForms = await cohorts
      .aggregate([
        //stage 1: find cohorts that match requirements
        {
          $match: {
            ano: year,
            semestre: semester,
          },
        },
        //stage 2: get related form data
        {
          $lookup: {
            from: "forms",
            localField: "codTurma",
            foreignField: "codTurma",
            as: "forms",
          },
        },
        //stage 3: filter properties
        {
          $project: {
            codTurma: 1,
            ano: 1,
            semestre: 1,
            forms: 1,
          },
        },
      ])
      .toArray();

    return filteredForms;
  } catch (e) {
    console.log("Main Chart Controller: Error retrieving forms:" + e);
  }
}

function calculateIndexByCategory(formData, category) {}
