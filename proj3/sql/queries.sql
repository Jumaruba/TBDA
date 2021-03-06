-- QUESTION A --

select f.id, f.name, r.description, a.activity 
from facilities f
inner join roomtypes r on f.roomtype = r.roomtype
inner join uses u on u.id = f.id 
inner join activities a on a.ref = u.ref 
where r.description like '%touros%' and a.activity='teatro'; 


-- QUESTION B -- 
select r.designation, count(f.name)
from facilities f 
inner join roomtypes r on r.roomtype = f.roomtype 
inner join municipalities m on m.cod = f.municipality 
inner join regions r on r.cod = m.region 
where r.description like '%touros%'
group by r.designation;

-- QUESTION C -- 

-- better approach 
select  c.counter - count(distinct m.cod) as non_cinema
from facilities f
inner join uses u on u.id = f.id 
inner join activities a on u.ref = a.ref 
inner join municipalities m on f.municipality = m.cod
cross join (select count(*) as counter from municipalities)  c
where a.activity = 'cinema'
group by counter;

-- second approach 
select count(*) - c.has_cinema as hasnt_cinema
from municipalities
cross join (
select count(distinct m.cod) as has_cinema
from facilities f
inner join uses u on u.id = f.id 
inner join activities a on u.ref = a.ref 
inner join municipalities m on f.municipality = m.cod
where a.activity = 'cinema') c
group by c.has_cinema;

-- QUESTION D - 

create view max_counter_activity as (
select max(counter) as counter, activity
from (
    select count(a.ref) as counter, a.activity as activity, m.designation as designation
    from facilities f 
    inner join uses u on u.id = f.id 
    inner join activities a on a.ref = u.ref
    inner join municipalities m on m.cod = f.municipality
    group by a.activity, m.designation
)
group by activity);

create view counts as (
select count(a.ref) as counter, a.activity as activity, m.designation as designation
from facilities f 
inner join uses u on u.id = f.id 
inner join activities a on a.ref = u.ref
inner join municipalities m on m.cod = f.municipality
group by a.activity, m.designation);

select m.counter, m.activity, c.designation
from max_counter_activity m 
inner join counts c on m.activity = c.activity and m.counter = c.counter
order by counter desc;

-- QUESTION E --

select cod,district from municipalities;
select * from facilities;

create view districtsWithNoFacilities as select cod,district from municipalities where not exists(select municipality from facilities where facilities.municipality = municipalities.cod);

select cod,designation from districts where cod in (select distinct district
from municipalities m
where not exists (
    select cod 
    from districtsWithNoFacilities df
    where df.district = m.district
));

-- QUESTION F --

select * from facilities;
select * from municipalities;

create view facilitiesByDistrict as select f.name,f.capacity,m.district
FROM facilities f
INNER JOIN municipalities m
ON f.municipality = m.cod;

select d.designation,f.district,round(avg(f.capacity),2) from facilitiesByDistrict f, districts d where d.cod=f.district group by f.district,d.designation;
    
