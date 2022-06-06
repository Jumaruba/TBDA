
-- Populate the regions. 

load csv with headers from 'file:///regions.csv' as line 
create (region: Region {
    cod: toInteger(line.cod),
    designation: line.designation,
    nut1: line.nut1})
return region; 

-- Populate districts.

load csv with headers from 'file:///districts.csv' as line
create (d: District {
    cod: line.cod,
    designation: line.designation,
    region: line.region
})
return d;

-- Populate municipalities. 

load csv with headers from 'file:///municipalities.csv' as line
create (m: Municipalities {
    cod: line.cod,
    designation: line.designation,
    region: line.region,
    district: line.district
})
return m;

-- Populate facilities. 

load csv with headers from 'file:///facilities.csv' as line
create (f: Facilities{
    id: line.id,
    name: line.name,
    capacity: line.capacity,
    roomtype: line.roomtype,
    address: line.address,
    municipality: line.municipality
})
return f;

-- Populate roomtype.

load csv with headers from 'file:///roomtypes.csv' as line
create (r: Roomtype{
    roomtype: line.roomtype,
    description: line.description
})
return r;

-- Populate activities.

load csv with headers from 'file:///activities.csv' as line
create (a: Activities{
    ref: line.ref,
    activity: line.activity
})
return a;



