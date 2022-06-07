var MongoClient = require('mongodb').MongoClient;
const data = require("./data/data.json");
const databaseName = "tbda";
const collectionName = "cultural_facilities";
const url = "mongodb://tbda:grupoa@vdbase.inesctec.pt:27017/?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&ssl=false";

MongoClient.connect(url, function (err, db) {
  if (err) throw err;
  const dbo = db.db(databaseName);
  createCollection(dbo);
  cleanCollection(dbo);
  populateCollection(dbo);
  db.close();
});

const createCollection = (dbo) => {
  dbo.createCollection(collectionName, function (err, res) {
    if (err) console.log("Collection already created!");
    console.log("Collection created!");
  });
}
const cleanCollection = (dbo) => {
  dbo.collection(collectionName).remove({});
}

const populateCollection = (dbo) => {
  dbo.collection(collectionName).insertMany(data, (err, res) => {
    if (err) throw err;
    console.log("Database populated!");
  });
}

