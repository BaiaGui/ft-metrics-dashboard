const { MongoClient } = require("mongodb");
require("dotenv").config();

let client;

async function connectDB() {
  console.log("to aqui");
  try {
    if (!client) {
      client = new MongoClient(process.env.DB_URI);
      await client.connect();
      console.log("Successfully connected to MongoDB!");
    }

    return client.db("ft_feedback_bd");
  } catch (e) {
    console.log("DB connection error:" + e);
  }
}

module.exports = connectDB;
