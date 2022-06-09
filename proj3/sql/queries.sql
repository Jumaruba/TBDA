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