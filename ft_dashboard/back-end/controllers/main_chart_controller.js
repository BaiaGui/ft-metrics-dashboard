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
    let filteredForms = await getFormsByTime(year, semester);
    //let answerProportion = getAnswerProportion(filteredForms);
    //let index = calculateIndexByCategory(filteredForms, 1);

    res.send(filteredForms);
  }
}

async function getFormsByTime(year, semester) {
  try {
    const cohorts = db.collection("cohorts");
    const formGroup = await cohorts
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
            as: "form",
          },
        },
        //stage 3: filter properties
        {
          $project: {
            codTurma: 1,
            ano: 1,
            semestre: 1,
            form: 1,
          },
        },
        //TEPORARY STAGES: LIMITING NUMBER OF DOCUMENTS TO VERIFY COUNT ALGORITHM
        {
          $unwind: {
            path: "$form",
          },
        },
        {
          $replaceRoot:
            /**
             * replacementDocument: A document or string.
             */
            {
              newRoot: "$form",
            },
        },
        {
          $limit: 3,
        },
      ])
      .toArray();

    return formGroup;
  } catch (e) {
    console.log("Main Chart Controller: Error retrieving forms:" + e);
  }
}

function calculateIndexByCategory(formData, category) {}

/*todo:
- think about how to choose category and how to filter questions
- create calculate index function
- ...
*/

/**
 * IMPORTANTE!
 * Para calcular o TIPO de resposta (concordo parcialmente, discordo totalmente, ...),
 * a função considera o NÚMERO da resposta. Ou seja, 1 = DT, 2 = DP, ...
 *
 */
function getAnswerProportion(form) {
  let answerProportion = [0, 0, 0, 0, 0, 0];
  for (let i = 0; i < form.questoes.length; i++) {
    // for (let j = 0; j < forms[i].questoes.length - 2; j++) {
    //   let answer = forms[i].questoes[j].resposta;
    //   answerProportion[answer]++;
    // }
    //console.log(form.questoes);
  }
}

function countFormAnswer(form) {
  let formAnswerProportion = [0, 0, 0, 0, 0, 0];
  form.questoes.forEach((question) => {
    formAnswerProportion[question.resposta]++;
  });
  console.log(formAnswerProportion);
}

module.exports = new MainChartController();
