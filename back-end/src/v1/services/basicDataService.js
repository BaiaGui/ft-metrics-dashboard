const indexesData = require("../data/basicDataData");

async function findYearsInDB() {
  let uniqueYears = await indexesData.findYearsInDB();
  return uniqueYears;
}

module.exports = {
  findYearsInDB,
};
