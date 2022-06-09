--QUESTION A--

db.cultural_facilities.aggregate(
    {"$unwind": "$municipalities"},
    {"$unwind": "$municipalities.facilities"}, 
    {"$match":{"municipalities.facilities.roomtype":/touros/,
    "municipalities.facilities.activities":"teatro"}},
    {"$project":{
        "Facility_id": "$municipalities.facilities._id",
        "Facility_name": "$municipalities.facilities.name",
        "Activities": "$municipalities.facilities.activities",
        "Roomtype": "$municipalities.facilities.roomtype",
        "_id":0}})

--QUESTION B--

db.cultural_facilities.aggregate(
    {"$unwind": "$municipalities"},
    {"$unwind": "$municipalities.facilities"}, 
    {"$match":{"municipalities.facilities.roomtype":/touros/}},
    {$group : {_id:"$municipalities.region", count:{$sum:1}}})


-- QUESTION D -- 
-- Considers that more than one municipality can have the biggest number of a certain activity. 
  db.cultural_facilities.aggregate([
    {$unwind: "$municipalities"},
    {$unwind: "$municipalities.facilities"},
    {$unwind: "$municipalities.facilities.activities"},
    {$group: {_id: {municipality: "$municipalities.designation", activity: "$municipalities.facilities.activities"}  , numTimes: {$sum: 1}}},
    {$group: {_id: {activity: "$_id.activity"}, maxTimes: {$max: "$numTimes"}, docs: {$push : {municipality: "$_id.municipality", numTimes: "$numTimes"}}}},
    {$project: {
      "_id": 0, 
      "activity": "$_id.activity",
      "maxTimes": "$maxTimes", 
      "facilities": {"$filter": {
        input: "$docs",
        as: "element",
        cond: {$eq: ["$$element.numTimes", "$maxTimes"]}
        }
      }
    }},
  ])

-- Considers that just one municipality can have the biggest number of a certain activity.
  db.cultural_facilities.aggregate([
    {$unwind: "$municipalities"},
    {$unwind: "$municipalities.facilities"},
    {$unwind: "$municipalities.facilities.activities"},
    {$group: {_id: {municipality: "$municipalities.designation", activity: "$municipalities.facilities.activities"}  , numTimes: {$sum: 1}}},
    {$sort: {"numTimes": -1}},
    {$group: {_id: {activity: "$_id.activity"}, numTimes: {$max: "$numTimes"}, docs: {$push : {municipality: "$_id.municipality"}}}},
    {$project: {
      "_id": 0, 
      "municipality": "$_id.municipality",
      "activity": "$_id.activity",
      "numTimes": "$numTimes", 
      "municipality": { $arrayElemAt: [ "$docs.municipality", 0 ] },
    }},
  ])

-- QUESTION E -- 

db.cultural_facilities.aggregate([
  {"$match": {"municipalities.facilities": {$ne: "null"}}},
  {"$project":{
    _id: 0,
    code: "$_id",
    designation: "$designation"
  }}
])

