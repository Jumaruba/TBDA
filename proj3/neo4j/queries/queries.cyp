// a) Which are the facilities where the room type description contains 'touros' and 
// have 'teatro' as one of their activities? Show the id, name, description and activity.

match(f:Facility)-[:HAS]->(a:Activity)
where f.roomtype contains 'touros' and a.activity = 'teatro'
return f.id, f.name, f.roomtype as description, a.activity;


// b) How many facilities with 'touros' in the room type description are there in each region? 

match(f:Facility)-[:LOCATED_AT]->(m:Municipality)-[:INSIDE_A]->(r:Region)
where f.roomtype contains "touro" 
return r.designation as Region, count(f) as Num_of_facilities;


// c) How many activities do not have any facility with an activity of 'cinema'? 
match (f:Facility)-[:HAS]->(a:Activity)
where a.activity=~ 'cinema'
return count(f);

// d) 


// e) 


// f)