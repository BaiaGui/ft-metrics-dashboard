const express = require("express");
const indexesController = require("../controllers/indexesController");

const router = express.Router();

//router.get("/years", indexesController.findYearsInDB);
router.get("/", indexesController.getIndex);
router.get("/:courseId", indexesController.getCourseIndex);
router.get("/:courseId/:groupId", indexesController.getSubjectGroupIndex);
module.exports = router;
