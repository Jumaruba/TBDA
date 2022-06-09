--QUESTION A--

db.cultural_facilities.aggregate(
    {"$unwind": "$municipalities"},
    {"$unwind": "$municipalities.facilities"}, 
    {"$match":{"municipalities.facilities.roomtype":/touros/,
    "municipalities.facilities.activities":"teatro"}},
    {"$project":{"municipalities.facilities._id":1,"municipalities.facilities.name":1,"municipalities.facilities.activities":1,"_id":0}})

--QUESTION B--

db.cultural_facilities.aggregate({"$unwind": "$municipalities"},{"$unwind": "$municipalities.facilities"}, {"$match":{"municipalities.facilities.roomtype":/touros/}},
{$group : {_id:"$municipalities.region", count:{$sum:1}}})

--QUESTION C--

count = db.cultural_facilities.aggregate({"$unwind": "$municipalities"},{"$unwind": "$municipalities.facilities"}, {$match : { "municipalities.facilities.activities": { "$nin": ["cinema"] } }},{
$count: "municipalities with facilities with no cinema"})