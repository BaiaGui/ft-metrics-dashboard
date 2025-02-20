function validateIndexesParams(req, res) {
  const { view, id } = req.params;
  availableViews = ["general", "course", "subjectGroup", "subject"];

  if (!availableViews.includes(view)) {
    res.status(404).json({
      error: `Invalid view parameter: "${view}". Accepted values are: general, course, subjectGroup, or subject. Please use one of these options.`,
    });
  }
  if (!view == "general" && !id) {
    res.status(400).json({ error: 'Invalid request: Missing required parameter "id".' });
  }

  next();
}
