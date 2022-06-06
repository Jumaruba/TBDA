// POPULATE ==================================================
// Regions

load csv with headers from 'file:///regions.csv' as line 
create (region: Region {
    cod: toInteger(line.cod),
    designation: line.designation,
    nut1: line.nut1})
return region; 

// Districts

load csv with headers from 'file:///districts.csv' as line
create (d: District {
    cod: line.cod,
    designation: line.designation,
    region: line.region
})
return d;

// Municipalities

load csv with headers from 'file:///municipalities.csv' as line
create (m: Municipality {
    cod: line.cod,
    designation: line.designation,
    region: line.region,
    district: line.district
})
return m;

// Facilities

load csv with headers from 'file:///facilities.csv' as line
create (f: Facility{
    id: line.id,
    name: line.name,
    capacity: line.capacity,
    roomtype: line.roomtype,
    address: line.address,
    municipality: line.municipality
})
return f;

// Roomtype

load csv with headers from 'file:///roomtypes.csv' as line
create (r: Roomtype{
    roomtype: line.roomtype,
    description: line.description
})
return r;

// Activities

load csv with headers from 'file:///activities.csv' as line
create (a: Activity{
    ref: line.ref,
    activity: line.activity
})
return a;


// RELATIONS =======================================================

load csv with headers from 'file:///uses.csv' as line
match 
    (a: Acitvity),
    (f: Facility)
    where line.id = f.id and line.ref = a.ref
    create (a)-[u:USES]->(f)
    return type(u);
    