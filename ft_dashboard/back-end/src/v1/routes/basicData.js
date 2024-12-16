const express = require("express");
const basicDataController = require("../controllers/basicDataController");

const router = express.Router();

router.get("/years", basicDataController.findYearsInDB);

module.exports = router;
