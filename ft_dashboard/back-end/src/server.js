const express = require("express");
const app = express();
const cors = require("cors");
const indexes = require("./v1/routes/indexes");
const surveyOverview = require("./v1/routes/surveyOverview");
const answerProportion = require("./v1/routes/answerProportion");
require("dotenv").config();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.use("/dashboard/indexes", indexes);
app.use("/dashboard/surveyOverview", surveyOverview);
app.use("/dashboard/answerProportion", answerProportion);

app.listen(process.env.PORT, () => {
  console.log(`Server running on port ${process.env.PORT}`);
});
