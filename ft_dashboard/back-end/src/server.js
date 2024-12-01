const express = require("express");
const app = express();
const indexes = require("./v1/routes/indexes");
const surveyOverview = require("./v1/routes/surveyOverview");
const answerProportion = require("./v1/routes/answerProportion");
require("dotenv").config();

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.use("/dashboard/indexes", indexes);
app.use("/dashboard/surveyOverview", surveyOverview);
app.use("/dashboard/answerProportion", answerProportion);

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
