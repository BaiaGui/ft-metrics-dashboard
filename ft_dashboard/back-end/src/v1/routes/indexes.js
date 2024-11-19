const express = require("express");
const indexesController = require("../controllers/indexesController");

const router = express.Router();

//router.get("/years", indexesController.findYearsInDB);
router.get("/index", indexesController.getIndex);

module.exports = router;