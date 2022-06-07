// a)

match(f:Facility)-[:HAS]->(a:Activity)
where f.roomtype contains 'touros' and a.activity = 'teatro'
return f.id, f.name, f.description, a.activity;


// b) 

match(f:Facility)-[:LOCATED_AT]->(m:Municipality)-[:INSIDE_A]->(r:Region)
where f.roomtype contains "touro" 
return r.designation as Region, count(f) as Num_of_facilities;

// c) How many activities do not have any facility with an activity of 'cinema'? 


