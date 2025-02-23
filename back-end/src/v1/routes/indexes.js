const express = require("express");
const indexesController = require("../controllers/indexesController");
const { validateIndexesParams } = require("../middlewares/validationMiddleware");
const router = express.Router();

router.get("/:view/:id", validateIndexesParams, indexesController.fetchIndexHistory);

module.exports = router;
