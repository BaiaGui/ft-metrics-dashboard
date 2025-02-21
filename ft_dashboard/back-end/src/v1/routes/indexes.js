const express = require("express");
const indexesController = require("../controllers/indexesController");
const { validateIndexesParams } = require("../middlewares/validationMiddleware");
const router = express.Router();

//View options: general, course, subjectGroup and subject

// router.get("/general", indexesController.getIndex);
// router.get("/course/:courseId", indexesController.getCourseIndex);
// router.get("/subjectGroup/:groupId", indexesController.getSubjectGroupIndex);
// router.get("/subject/:subjectId", indexesController.getSubjectIndex);
router.get("/:view/:id", validateIndexesParams, indexesController.fetchIndexHistory);

module.exports = router;
