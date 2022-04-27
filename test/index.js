const express = require("express");
const ParseServer = require("parse-server").ParseServer;

const parseConfig = {
    databaseURI: "mongodb://localhost:27017/mydb",
    appId: "myAppId",
    masterKey: "secretKey",
    serverURL: "http://localhost:3000/parse",
};

const parseApi = new ParseServer(parseConfig);

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!')
});

app.use("/parse", parseApi);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});
