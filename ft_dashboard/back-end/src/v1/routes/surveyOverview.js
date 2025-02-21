const express = require("express");
const surveyOverviewController = require("../controllers/surveyOverviewController");
const { validateIndexesParams } = require("../middlewares/validationMiddleware");

const router = express.Router();

// router.get("/", surveyOverviewController.getGeneralInfo);
// router.get("/:courseId", surveyOverviewController.getGeneralCourseInfo);
// router.get("/:courseId/:groupId", surveyOverviewController.getGeneralGroupInfo);
router.get("/:view/:id", validateIndexesParams, surveyOverviewController.fetchSurveyInfo);
module.exports = router;
