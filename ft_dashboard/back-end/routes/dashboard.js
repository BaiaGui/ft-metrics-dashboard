const express = require("express");
const mainChartController = require("../controllers/main_chart_controller");
const router = express.Router();

router.get("/", (req, res) => {
  res.send("hi!");
});

router.get("/index", mainChartController.getIndex);
//router.get("/index");

module.exports = router;
