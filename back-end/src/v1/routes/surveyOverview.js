const express = require("express");
const surveyOverviewController = require("../controllers/surveyOverviewController");
const { validateIndexesParams } = require("../middlewares/validationMiddleware");

const router = express.Router();

router.get("/:view/:id", validateIndexesParams, surveyOverviewController.fetchSurveyInfo);
module.exports = router;
