const express = require("express");
const app = express();
const dashboard = require("./routes/dashboard");

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.use("/dashboard", dashboard);

const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
