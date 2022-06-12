// POPULATE ==================================================
// Regions

load csv with headers from 'file:///regions.csv' as line FIELDTERMINATOR ';'
create (region: Region {
    cod: toInteger(line.COD),
    designation: line.DESIGNATION,
    nut1: line.NUT1})
return region; 

// Districts

load csv with headers from 'file:///districts.csv' as line FIELDTERMINATOR ';'
create (d: District {
    cod: toInteger(line.COD),
    designation: line.DESIGNATION,
    region: toInteger(line.REGION)
})
return d;

// Municipalities

load csv with headers from 'file:///municipalities.csv' as line  FIELDTERMINATOR ';'
create (m: Municipality {
    cod: toInteger(line.COD),
    designation: line.DESIGNATION,
    region: toInteger(line.REGION),
    district: toInteger(line.DISTRICT)
})
return m;

// Facilities

load csv with headers from 'file:///facilities.csv' as line FIELDTERMINATOR ';'
create (f: Facility{
    id:line.ID,
    name: line.NAME,
    capacity: toInteger(line.CAPACITY),
    roomtype: line.ROOMTYPE,
    address: line.ADDRESS,
    municipality: toInteger(line.MUNICIPALITY)
})
return f;

// Roomtype

load csv with headers from 'file:///roomtypes.csv' as line FIELDTERMINATOR ';'
create (r: Roomtype{
    roomtype: line.ROOMTYPE,
    description: line.DESCRIPTION
})
return r;

// Activities

load csv with headers from 'file:///activities.csv' as line FIELDTERMINATOR ';'
create (a: Activity{
    ref: line.REF,
    activity: line.ACTIVITY
})
return a;


// RELATIONS =======================================================

// Acitvity-USES->Facility ----

load csv with headers from 'file:///uses.csv' as line  FIELDTERMINATOR ';'
match (a: Activity {ref: line.REF})
match (f: Facility {id: line.ID})
// merge (a)-[:USES]->(f);
merge (f)-[:HAS]->(a); 

// Add roomtype to facilities directly ----

MATCH (r:Roomtype), (f:Facility {roomtype:r.roomtype})
set f.roomtype=r.description;

// Deleting roomtype nodes
match (a:Roomtype) delete a;


// Facility-LOCATED_AT->Municipality

match (f:Facility)
match (m:Municipality {cod: f.municipality})
merge (f)-[:LOCATED_AT]->(m);

// Municipality-BELONGS_TO->District 
match (m: Municipality)
match (d: District {cod: m.district})
merge (m)-[:BELONGS_TO]->(d); 

// Municipality-INSIDE_A->Region 
match (m: Municipality)
match (r:Region {cod: m.region})
merge (m)-[:INSIDE_A]->(r); 

