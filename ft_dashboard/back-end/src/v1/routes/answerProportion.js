const express = require("express");
const answerProportionController = require("../controllers/answerProportionController");

const router = express.Router();

router.get("/", answerProportionController.getCourseProportion);
router.get("/:courseId", answerProportionController.getSubjectGroupProportion);
router.get("/:courseId/:groupId", answerProportionController.getSubjectsProportion);

module.exports = router;
