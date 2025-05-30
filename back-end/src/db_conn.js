const { MongoClient } = require("mongodb");
require("dotenv").config();

let client;

async function connectDB() {
  try {
    if (!client) {
      client = new MongoClient(process.env.DB_URI);
      await client.connect();
      console.log("Successfully connected to MongoDB!");
    }

    return client.db("avaliacao_prof_tcc");
  } catch (e) {
    console.log("DB connection error:" + e);
  }
}

module.exports = connectDB;
