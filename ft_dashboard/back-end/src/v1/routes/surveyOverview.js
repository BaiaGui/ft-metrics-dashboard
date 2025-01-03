const express = require("express");
const surveyOverviewController = require("../controllers/surveyOverviewController");

const router = express.Router();

//router.get("/", surveyOverviewController.);
router.get("/", surveyOverviewController.getGeneralInfo);
router.get("/:courseId", surveyOverviewController.getGeneralCourseInfo);

module.exports = router;
