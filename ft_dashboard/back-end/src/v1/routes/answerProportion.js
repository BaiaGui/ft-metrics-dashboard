const express = require("express");
const answerProportionController = require("../controllers/answerProportionController");
const { validateAnswerProportionParams } = require("../middlewares/validationMiddleware");

const router = express.Router();

router.get("/:view/:id", validateAnswerProportionParams, answerProportionController.fetchProportions);

module.exports = router;
