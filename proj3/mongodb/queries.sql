--QUESTION A--

db.cultural_facilities.aggregate(
    {"$unwind": "$municipalities"},
    {"$unwind": "$municipalities.facilities"}, 
    {"$match":{"municipalities.facilities.roomtype":/touros/,
    "municipalities.facilities.activities":"teatro"}},
    {"$project":{"municipalities.facilities._id":1,"municipalities.facilities.name":1,"municipalities.facilities.activities":1,"_id":0}})