const express = require("express");
const answerProportionController = require("../controllers/answerProportionController");

const router = express.Router();

router.get("/", answerProportionController.getAllCourses);
//router.get("/index", answerProportionController.findLatestDate);

module.exports = router;
