const express = require("express");
const indexesController = require("../controllers/indexesController");

const router = express.Router();

router.get("/", indexesController.findLatestDate);
router.get("/index", indexesController.findLatestDate);

module.exports = router;
