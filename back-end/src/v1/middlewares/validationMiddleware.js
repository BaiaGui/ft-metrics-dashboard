function validateIndexesParams(req, res, next) {
  const { view, id } = req.params;
  availableViews = ["general", "course", "subjectGroup", "subject"];

  if (!availableViews.includes(view)) {
    console.log(`Invalid view parameter: "${view}". Accepted values are: general, course, subjectGroup, or subject. Please use one of these options.`);
    res.status(404).json({
      error: `Invalid view parameter: "${view}". Accepted values are: general, course, subjectGroup, or subject. Please use one of these options.`,
    });
  } else {
    next();
  }
}

function validateAnswerProportionParams(req, res, next) {
  const { view, id } = req.params;
  availableViews = ["general", "course", "subjectGroup", "subject", "comments"];

  if (!availableViews.includes(view)) {
    console.log(`Invalid view parameter: "${view}". Accepted values are: general, course, subjectGroup, or subject. Please use one of these options.`);
    res.status(404).json({
      error: `Invalid view parameter: "${view}". Accepted values are: general, course, subjectGroup, or subject. Please use one of these options.`,
    });
  } else {
    next();
  }
}

module.exports = {
  validateIndexesParams,
  validateAnswerProportionParams,
};
