const { MongoClient, ServerApiVersion } = require("mongodb");
require("dotenv").config();

// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(process.env.DB_URI);

async function run() {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await client.connect();
    // Send a ping to confirm a successful connection
    client.db("ft_feedback_bd").command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
  } catch (e) {
    // Ensures that the client will close when you finish/error
    console.log(e);
  }
}
run().catch(console.dir);
const db = client.db("ft_feedback_bd");

module.exports = db;
