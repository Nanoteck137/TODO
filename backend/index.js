require("dotenv").config();

const mongoose = require("mongoose");
const express = require('express');

const app = express()
const port = process.env.SERVER_PORT || 3000;

app.use(express.json());

function err(msg) {
    throw new Error(msg);
}

let mongo_uri = process.env.MONGO_URI || err("MONGO_URI not defined");
mongoose.connect(mongo_uri, { useNewUrlParser: true, useUnifiedTopology: true });

let db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));

app.use("/api", require("./routes/api/todos"));

app.listen(port, () => {
    console.log(`Backend listening on port ${port}`)
})
