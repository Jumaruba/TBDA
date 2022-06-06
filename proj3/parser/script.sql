
-- GET ACTIVITES 
create or replace function get_activities(facility_id varchar2) return clob is 
    jo clob;
begin  
    select json_arrayagg(a.activity returning clob) into jo
    from facilities f, activities a, uses u
    where f.id = facility_id and u.id = facility_id and a.ref = u.ref;
    return jo;
end get_activities;
/
-- GET FACILITY ROOM TYPE
create or replace function get_roomtype(roomtype_id varchar2) return clob is 
    c clob; 
begin 
    select r.description into c
    from roomtypes r
    where r.roomtype = roomtype_id; 
    return c;
end get_roomtype;

/
-- GET FACITILIES 
create or replace function get_facilities(municipality_id varchar2) return clob is 
    jo clob;
begin 
    select json_arrayagg(
        json_object(
            '_id'           value f.id,
            'name'          value f.name,
            'capacity'      value f.capacity, 
            'roomtype'      value get_roomtype(f.roomtype),
            'address'       value f.address,
            'activities'    value get_activities(f.id)
        format json returning clob)
    format json returning clob) into jo
    from facilities f
    where f.municipality = municipality_id;
    return jo; 
end get_facilities;
/
            
-- GET REGION OF A MUNICIPALITY 
create or replace function get_region(region_id varchar2) return clob is
    jo clob; 
begin 
    select json_object(
        '_id'           value r.cod,
        'designation'   value r.designation,
        'nut1'          value r.nut1
        returning clob) into jo
    from regions r
    where region_id = r.cod;
    return jo;
end get_region;         
/


-- GET THE MUNICIPALITIES 
create or replace function get_municipalities(district_id varchar2) return clob is
    jo clob;    -- store the result
begin 
    select json_arrayagg(json_object(
        '_id'           value m.cod,
        'designation'   value m.designation,
        'region'        value get_region(m.region) format json,
        'facilities'    value get_facilities(m.cod) format json 
        returning clob) format json returning clob) into jo
    from municipalities m
    join districts d on d.cod = m.district
    where d.cod = district_id; 
    return jo;
end get_municipalities;

/
select json_object( '_id'               value cod,
                    'designation'       value designation,
                    'municipalities'    value get_municipalities(cod)
                     format json returning clob)
from districts;

    


    
    
    


    
    
    


    
    
    
    


    
    
    

    
    
    