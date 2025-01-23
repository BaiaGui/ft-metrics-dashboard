const express = require("express");
const surveyOverviewController = require("../controllers/surveyOverviewController");

const router = express.Router();

//router.get("/", surveyOverviewController.);
router.get("/", surveyOverviewController.getGeneralInfo);
router.get("/:courseId", surveyOverviewController.getGeneralCourseInfo);
router.get("/:courseId/:groupId", surveyOverviewController.getGeneralGroupInfo);
module.exports = router;
