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
match (m:Municipality)
match  (m1:Municipality)<-[:LOCATED_AT]-(f:Facility)-[:HAS]->(:Activity {activity: "cinema"})
with count(distinct m1) as non_cinema_count, count(distinct m) as total_count
return total_count - non_cinema_count;

// d) d. Which is the municipality with more facilities engaged in each of the six kinds of activities? 
//Show the activity, the municipality name and the corresponding number of facilities
MATCH (a:Activity)<-[:HAS]-(f:Facility)-[:LOCATED_AT]->(m:Municipality) with a,m,count(f) as num_fac
WITH a, collect(m) as mun, collect(num_fac) as facs WITH a, mun, facs,
reduce(x=[0,0], idx in range(0,size(facs)-1) | case when facs[idx] > x[1] then [idx,facs[idx]] else x end)[0] as index
return a.activity AS Activity, mun[index].designation AS Municipality, facs[index] As num ORDER BY Activity


// e) Which are the codes and designations of the districts with facilities in all the municipalities?
MATCH (m:Municipality) WHERE  NOT ()-[:LOCATED_AT]->(m) WITH collect(m) as mun
MATCH (m:Municipality)-[:BELONGS_TO]->(d:District) WHERE ALL(x IN mun WHERE NOT (x)--(d)) 
WITH DISTINCT d RETURN d.cod, d.designation 

// f) Which are the average facilities capacity in each district?
MATCH (f:Facility)-[:LOCATED_AT]->(m:Municipality)-[:BELONGS_TO]->(d:District)
WITH d.designation as Distrito, round(apoc.coll.avg(collect(f.capacity)), 2) as Capacidade_Media 
RETURN Distrito, Capacidade_Media